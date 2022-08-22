//
//  Float+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Float {
    /// Check if Float is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if Float is negative.
    var isNegative: Bool {
        return self < 0
    }

    func toInt() -> Int {
        Int(self)
    }

    func toString() -> String {
        String(format: "%.02f", self)
    }

    var clearCommaDigit: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Optional where Wrapped == Float {

}

