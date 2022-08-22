//
//  Double+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Double {
    /// Check if Double is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if Double is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    func toInt() -> Int {
        Int(self)
    }

    func toString() -> String {
        String(format: "%.02f", self)
    }

    var toDefaultCurrencyFormat: String {
        return NumberFormatHelper.shared.defaultPriceFormat(price: self)
    }

    var clearCommaDigit: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Optional where Wrapped == Double {

    var toDefaultCurrencyFormat: String {
        if let guardValue = self {
            return guardValue.toDefaultCurrencyFormat
        }
        return "0.00"
    }
}

