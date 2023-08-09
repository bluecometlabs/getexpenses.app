#!/usr/bin/env swift

import Foundation

struct ReferenceRatesRef: Decodable {
    var base: String
    var date: String
    var rates: [String: Double]
}

let base = "EUR"
let symbols = "AED,AFN,ALL,AMD,ANG,AOA,ARS,AUD,AWG,AZN,BAM,BBD,BDT,BGN,BHD,BIF,BMD,BND,BOB,BRL,BSD,BTN,BWP,BYN,BYR,BZD,CAD,CDF,CHF,CLF,CLP,CNY,COP,CRC,CUC,CUP,CVE,CZK,DJF,DKK,DOP,DZD,EGP,ERN,ETB,FJD,FKP,GBP,GEL,GHS,GIP,GMD,GNF,GTQ,GYD,HKD,HNL,HRK,HTG,HUF,IDR,ILS,INR,IQD,IRR,ISK,JMD,JOD,JPY,KES,KGS,KHR,KMF,KPW,KRW,KWD,KYD,KZT,LAK,LBP,LKR,LRD,LSL,LTL,LVL,LYD,MAD,MDL,MGA,MKD,MMK,MNT,MOP,MRO,MUR,MVR,MWK,MXN,MYR,MZN,NAD,NGN,NIO,NOK,NPR,NZD,OMR,PAB,PEN,PGK,PHP,PKR,PLN,PYG,QAR,RON,RSD,RUB,RWF,SAR,SBD,SCR,SDG,SEK,SGD,SHP,SLL,SOS,SRD,STD,SYP,SZL,THB,TJS,TMT,TND,TOP,TRY,TTD,TWD,TZS,UAH,UGX,USD,UYU,UZS,VND,VUV,WST,XAF,XAG,XAU,XCD,XDR,XOF,XPF,YER,ZAR,ZMK,ZMW,ZWL"
let expectedNumberOfCurrencyCodes = symbols.components(separatedBy: ",").count

let url = "https://api.apilayer.com/fixer/latest?base=\(base)&symbols=\(symbols)"
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

        let numberOfCurrencyCodes = referenceRatesRef.rates.count
        print("Number of currency codes: \(numberOfCurrencyCodes)/\(expectedNumberOfCurrencyCodes)")

        if numberOfCurrencyCodes != expectedNumberOfCurrencyCodes {
            let currencyCodes = referenceRatesRef.rates.map { $0.0 }.sorted()
            let expectedCurrencyCodes = symbols.components(separatedBy: ",").sorted()
            let diff = currencyCodes.difference(from: expectedCurrencyCodes)
            fatalError("Error: number of currency codes does not match [\(diff.joined(separator: ", "))]")
        }
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
            .filter { Locale.Currency.isoCurrencies.map(\.identifier).contains($0.key)  }
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

    let filePath = FileManager.default.currentDirectoryPath + "/eurofxref/eurofxref.xml"

    if FileManager.default.createFile(atPath: filePath, contents: contents, attributes: nil) {
        print("File updated successfully.")
    } else {
        print("File not updated.")
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
