//
//  NumberFormatHelper.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Foundation

struct NumberFormatHelper {

    private init() { }

    static let shared = NumberFormatHelper()

    func defaultPriceFormat(price: Double) -> String {
        let formatted = getCurrencyFormatter().string(from: NSNumber(value: price)) ?? ""
        let splitFormattedText = formatted.split(separator: ",")
        if splitFormattedText.count > 0 {
            let lastElement = splitFormattedText.last
            if lastElement == "0" || lastElement == "00" {
                return formatted.replacingOccurrences(of: ",00", with: "")
            }
        }
        return formatted
    }

    func priceFormatWithName(price: Double) -> String {
        var formattedText = ""
        var tempPrice = price

        if tempPrice > 99_9999 && tempPrice < 999_999_999 {
            tempPrice = Double(Int(tempPrice)) / 1_000_000
            formattedText = getDecimalThousandsFormatter().string(from: NSNumber(value: tempPrice)) ?? "\(tempPrice)"
            formattedText = "\(formattedText) Milyon"
        } else if tempPrice > 999_999_999 {
            tempPrice = Double(Int(tempPrice)) / 1_000_000_000
            formattedText = getDecimalThousandsFormatter().string(from: NSNumber(value: tempPrice)) ?? "\(tempPrice)"
            formattedText = "\(formattedText) Milyar"
        } else {
            formattedText = getCurrencyFormatter().string(from: NSNumber(value: price)) ?? ""
        }

        return formattedText
    }

    func thousandsStyleFormat(value: Double) -> String {
        return getDecimalThousandsFormatter().string(from: NSNumber(value: value)) ?? "\(value)"
    }

    func getDecimalThousandsFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }

    func getCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.locale = Locale(identifier: "tr")
        return formatter
    }
}
