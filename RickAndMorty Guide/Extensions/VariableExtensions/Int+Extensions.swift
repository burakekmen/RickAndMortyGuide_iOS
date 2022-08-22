//
//  Int+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation
import UIKit

extension Int {

    /// Check if Int is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if Int is negative.
    var isNegative: Bool {
        return self < 0
    }
    
    var toLayoutPriority: UILayoutPriority {
        return .init(rawValue: Float(self))
    }
    
    func toDouble() -> Double {
        Double(self)
    }

    func toString() -> String {
        "\(self)"
    }
    
    func toNSRange(length: Int) -> NSRange {
        return NSRange(location: self, length: length)
    }
    
    func formatWithThousandsSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        let formattedNumber = formatter.string(from: NSNumber(value: self))
        return formattedNumber ?? "\(self)"
    }

}

