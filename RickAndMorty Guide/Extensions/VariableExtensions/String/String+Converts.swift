//
//  String+Converts.swift
//  RickAndMortyGuide
//
//  
//

import Foundation
import CoreLocation

extension String { 

    var digits: String { // Pure Number
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var alphanumerics: String {
        return components(separatedBy: CharacterSet.decimalDigits).joined()
    }

    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trim() {
        self = self.trimmed
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var asURL: URL? {
        URL(string: self)
    }

    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }

    var asArray: [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
    }

    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }

    var asCoordinates: CLLocationCoordinate2D? {
        let components = self.components(separatedBy: ",")
        if components.count != 2 { return nil }
        let strLat = components[0].trimmed
        let strLng = components[1].trimmed
        if let dLat = Double(strLat),
            let dLng = Double(strLng) {
            return CLLocationCoordinate2D(latitude: dLat, longitude: dLng)
        }
        return nil
    }

    func toInt() -> Int {
        Int(self)!
    }

    func toIntOrNull() -> Int? {
        Int(self)
    }

    func toNSMutableAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    func toNSAttributeString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }

    func upperCasedTR() -> String {
        return self.uppercased(with: Locale.TR)
    }

    func lowerCasedTR() -> String {
        return self.lowercased(with: Locale.TR)
    }
    
    func capitalizedTR() -> String {
        return self.capitalized(with: Locale.TR)
    }

    func toPhoneNumber() -> String {
        let digits = self.digits
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d{2})(\\d{2})", with: "($1) $2 $3 $4", options: .regularExpression, range: nil)
        }
        else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d{2})(\\d{2})", with: "$1 ($2) $3 $4 $5", options: .regularExpression, range: nil)
        }
        else {
            return self
        }
    }

    func toOfficeNumber() -> String {
        let digits = self.digits
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d{2})(\\d{2})", with: "$1 $2 $3 $4", options: .regularExpression, range: nil)
        } else if digits.count == 7 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{2})(\\d{2})", with: "$1 $2 $3", options: .regularExpression, range: nil)
        } else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d{2})(\\d{2})", with: "$1 $2 $3 $4 $5", options: .regularExpression, range: nil)
        } else {
            return self
        }
    }
}


extension String{
    static func randomString(ofLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let value = String((0..<length).map{ _ in letters.randomElement()! })
        return value
    }
}
