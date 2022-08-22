//
//  String+Extensions.swift
//  CountryPicker
//
//  Created by Samet Macit on 31.12.2020
//  Copyright © 2021 Mobven. All rights reserved.

import Foundation

public extension String {
    /// Returns String unicode value of country flag for iso code
    func getFlag() -> String {
        unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    // MARK: - Old Project Extensions START
    
    func renameCurrency() -> String {
        let text = self
        
        switch text {
        case "TRY":
            return "TL"
        default:
            return text
        }
    }
    
    func getDate() -> String {
        if let intValue = Int(self) {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatterGet.string(from: Date(timeIntervalSince1970: TimeInterval(intValue)/1000))
        }
        return self
    }
    // MARK: - Old Project Extensions END
}
