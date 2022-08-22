//
//  String+RegularExpressions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension String {

    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
        case phone_long_regex = "(([+]?\\d{2})|\\d?)[ \\t-]*[(]?[ \\t-]*[0-9]{3,4}[ \\t-]*[)]?[ \\t-]*[0-9]{3}[ \\t-]*[0-9]{2}[ \\t-]*[0-9]{2}|([ \\t-]*[0-9]{3}[ \\t-]*[0-9]{2}[ \\t-]*[0-9]{2})"
    }

    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }

    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }

    func isValidEmail() -> Bool {
        let email = self
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidWord() -> Bool {
        let nameAndSurname = self
        let nameAndSurnameRegEx = "^[a-zA-ZşŞıİçÇöÖüÜĞğ ]+$" // Sadece Latin Harf Girişi

        let nameAndSurnamePred = NSPredicate(format: "SELF MATCHES %@", nameAndSurnameRegEx)
        return nameAndSurnamePred.evaluate(with: nameAndSurname)
    }
/*
    func isValidNumber() -> Bool {
        let phoneNumber = self
        let phoneNumberRegEx = "^[0-9]"

        let phoneNumberPred = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumberPred.evaluate(with: phoneNumber)
    }
*/
    var isValidURL: Bool {
        return isStringLink(string: self)
    }

    private func isStringLink(string: String) -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard detector != nil && !string.isEmpty else { return false }
        if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: string.count)) > 0 {
            return true
        }
        return false
    }
}

// MARK: Regex
extension String {

    // Regex ile eşleşenlerin listesini döndürüyor.
    func regexMatches(regex: RegularExpressions) -> [String] {
        if let rgx = try? NSRegularExpression(pattern: regex.rawValue, options: .caseInsensitive) {
            let string = self as NSString
            let range = NSRange(location: 0, length: string.length)
            return rgx.matches(in: self, options: [], range: range).map {
                string.substring(with: $0.range)
            }
        }

        return []
    }

    /* func replaceFirst(of pattern: String, with replacement: String) -> String {
        if let range = self.range(of: pattern) {
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
    }
    */

    // Regex ile eşleşenleri değiştirme işlemi yapıyor.
    /*  func replaceAll(of pattern: String, with replacement: String, options: NSRegularExpression.Options = []) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let range = NSRange(location: 0, length: self.count) //NSRange(0..<self.utf16.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
        } catch {
            //NSLog("replaceAll error: \(error)")
            return self
        }
    } */
}
