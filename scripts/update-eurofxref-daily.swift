#!/usr/bin/env swift

import Foundation

struct ReferenceRatesRef: Decodable {
    var base: String
    var date: String
    var rates: [String: Double]
}

let base = "EUR"
let url = "https://api.apilayer.com/fixer/latest?base=\(base)"
let apiKey = CommandLine.arguments[1]

var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"
request.addValue(apiKey, forHTTPHeaderField: "apikey")

var semaphore = DispatchSemaphore (value: 0)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else {
        print(String(describing: error))
        return
    }

    do {
        let referenceRatesRef = try JSONDecoder().decode(ReferenceRatesRef.self, from: data)
        updateEurofxrefFile(referenceRatesRef: referenceRatesRef)
    } catch {
        print(String(describing: error))
    }

    semaphore.signal()
}

task.resume()
semaphore.wait()

func updateEurofxrefFile(referenceRatesRef: ReferenceRatesRef) {
    let rates: String = {
        var result = ""
        let sortedRates = referenceRatesRef.rates
            .filter { $0.key != base }
            .sorted { $0.key < $1.key }
        for (index, rate) in sortedRates.enumerated() {
            // E.g., <Cube currency="USD" rate="1.0163"/>
            if index == sortedRates.endIndex - 1 {
                result += "<Cube currency=\"\(rate.key)\" rate=\"\(rate.value)\"/>"
            } else {
                result += "<Cube currency=\"\(rate.key)\" rate=\"\(rate.value)\"/>\n"
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
    <Cube time="\(referenceRatesRef.date)">
    \(rates)
    </Cube>
    </Cube>
    </gesmes:Envelope>
    """.data(using: .utf8)!

    let filePath = FileManager.default.currentDirectoryPath + "/eurofxref/eurofxref-daily.xml"

    if FileManager.default.createFile(atPath: filePath, contents: contents, attributes: nil) {
        print("File updated successfully.")
    } else {
        print("File not updated.")
    }
}
