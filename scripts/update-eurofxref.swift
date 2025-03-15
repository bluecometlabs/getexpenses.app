#!/usr/bin/env swift

import Foundation

struct ReferenceRate: Decodable, Comparable {
    var rate: Double
    var source: String
    var target: String
    var time: String

    static func < (lhs: ReferenceRate, rhs: ReferenceRate) -> Bool {
        return lhs.target < rhs.target
    }
}

var referenceRates: [ReferenceRate] = []
var time = ""
let base = "EUR"

let supportedCurrencies = try {
    let filePath = FileManager.default.currentDirectoryPath + "/scripts/currencies.json"
    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    return try JSONDecoder().decode([String].self, from: data).filter { $0 != base }.sorted()
}()

// Wise API
// Documentation: https://docs.wise.com/api-docs/api-reference/rate
do {
    let url = "https://api.wise.com/v1/rates?source=\(base)"
    let apiKey = CommandLine.arguments[1]
    let nonISOCurrencies = ["GGP", "IMP", "JEP"]

    var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        print("Error: \(String(describing: response))")
        exit(1)
    }

    let rates = try JSONDecoder().decode([ReferenceRate].self, from: data)
        .filter { !nonISOCurrencies.contains($0.target) }

    print("Wise: \(rates.count) reference rates")
    referenceRates.append(contentsOf: rates)
    // E.g. 2024-01-01
    time = String(rates[0].time.prefix(10))
} catch {
    print(String(describing: error))
    exit(1)
}

// Fixer API (maintain the backward compatibility)
// Documentation: https://apilayer.com/marketplace/exchangerates_data-api
struct FixerReferenceRates: Decodable {
    var base: String
    var date: String
    var rates: [String: Double]
}

if CommandLine.arguments.count > 2 {
    do {
        let symbols = ["BYR", "CLF", "LTL", "LVL", "STD", "XAG", "XAU", "XDR", "ZMK"]
        let url = "https://api.apilayer.com/fixer/latest?base=\(base)&symbols=\(symbols.joined(separator: ","))"
        let apiKey = CommandLine.arguments[2]

        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Error: \(String(describing: response))")
            exit(1)
        }

        let fixerReferenceRates = try JSONDecoder().decode(FixerReferenceRates.self, from: data)
        let rates = fixerReferenceRates.rates.map {
            ReferenceRate(rate: $0.value, source: fixerReferenceRates.base, target: $0.key, time: fixerReferenceRates.date)
        }

        print("Fixer: \(rates.count) reference rates")
        referenceRates.append(contentsOf: rates)
    } catch {
        print(String(describing: error))
        exit(1)
    }
}

let sortedReferenceRates = referenceRates.sorted()
print("Total: \(sortedReferenceRates.count) reference rates")

// Check if all currencies are supported
let unsupportedCurrencies = sortedReferenceRates.filter { !supportedCurrencies.contains($0.target) }
if !unsupportedCurrencies.isEmpty {
    print("Error: \(unsupportedCurrencies.map(\.target)) are not supported.")
    exit(1)
}

// Check if any currency is missing
let missingCurrencies = supportedCurrencies.filter { !sortedReferenceRates.map(\.target).contains($0) }
if !missingCurrencies.isEmpty {
    print("Error: \(missingCurrencies) are missing.")
    exit(1)
}

// Check if all currency codes are valid
let invalidCurrencies = sortedReferenceRates.filter { !Locale.Currency.isoCurrencies.map(\.identifier).contains($0.target) }
if !invalidCurrencies.isEmpty {
    print("Error: \(invalidCurrencies.map(\.target)) are not valid currency codes.")
    exit(1)
}

let rates: String = {
    var result = ""
    for (index, referenceRate) in sortedReferenceRates.enumerated() {
        // E.g., <Cube currency="USD" rate="1.0163"/>
        if index == sortedReferenceRates.endIndex - 1 {
            result += "<Cube currency=\"\(referenceRate.target)\" rate=\"\(referenceRate.rate)\"/>"
        } else {
            result += "<Cube currency=\"\(referenceRate.target)\" rate=\"\(referenceRate.rate)\"/>\n"
        }
    }
    return result
}()

let contents = """
<gesmes:Envelope xmlns:gesmes="http://www.gesmes.org/xml/2002-08-01" xmlns="https://getexpenses.app/eurofxref">
<gesmes:subject>Reference rates</gesmes:subject>
<gesmes:Sender>
<gesmes:name>Expenses</gesmes:name>
</gesmes:Sender>
<Cube>
<Cube time="\(time)">
\(rates)
</Cube>
</Cube>
</gesmes:Envelope>
""".data(using: .utf8)!

let filePath = FileManager.default.currentDirectoryPath + "/eurofxref/eurofxref.xml"

if FileManager.default.createFile(atPath: filePath, contents: contents, attributes: nil) {
    print("\nFile updated successfully.")
} else {
    print("\nFile not updated.")
}
