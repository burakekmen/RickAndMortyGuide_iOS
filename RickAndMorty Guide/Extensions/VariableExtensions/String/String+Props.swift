//
//  String+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension String {

    func addingEncodingUrlFragmentAllowed() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? self
    }

    func findRangeOf(certainText: String) -> NSRange {
        return (self as NSString).range(of: certainText, options: .caseInsensitive)
    }

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    func getFirstLettersForDisplay() -> String {
        let letters = self.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")

        var firstLetters = ""

        if !letters.isEmpty {
            firstLetters = "\(letters.first!.prefix(1))"

            if letters.count > 1 {
                firstLetters = "\(firstLetters)\(letters.last!.prefix(1))"
            }
        }

        return firstLetters
    }

    func changeCharacterTurkishtoEnglish() -> String {
        let turkish = ["ı", "ğ", "ü", "ş", "ö", "ç"]
        let english = ["i", "g", "u", "s", "o", "c"]

        var stringOfEng = ""
        for char in self {
            if turkish.contains("\(char)") {
                if let index = turkish.firstIndex(of: "\(char)") {
                    stringOfEng.append(self.replacingOccurrences(of: self, with: english[index]))
                }
            } else {
                stringOfEng.append(char)
            }
        }
        return stringOfEng
    }

    func getNSRange(fromRange range: Range<Index>) -> NSRange {
        let from = range.lowerBound
        let to = range.upperBound

        let location = self.distance(from: startIndex, to: from)
        let length = self.distance(from: from, to: to)

        return NSRange(location: location, length: length)
    }

    func getRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

    // verilen elementin tüm indexlerini bulup array olarak geri döner
    // burak
    // ör: indexOfAllNotNil(to: "b") -> [0,2]
    func indexOfAllNotNil(to: String.Element) -> [Int] {
        return self.enumerated().compactMap { $0.element == to ? $0.offset: nil }
    }

    func addDecimalPoints() -> String {
        let noDots = self.replacingOccurrences(of: ".", with: "")
        if let intValue = Int(noDots) {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "."
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: intValue))!
        }
        return self
    }

    mutating func insert(_ string: String, at: Int) {
        self.insert(contentsOf: string, at: self.index(self.startIndex, offsetBy: at))
    }

    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func truncate(to length: Int, addEllipsis: Bool = false) -> String {
        if length > count { return self }

        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }

    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}

// MARK: Separate Characters Into Groups
/**How to use
 var cardNumber = "1234567890123456"
 cardNumber.insert(separator: " ", every: 4)
 print(cardNumber)
 // 1234 5678 9012 3456
 let pin = "7690"
 let pinWithDashes = pin.inserting(separator: "-", every: 1)
 print(pinWithDashes)
 // 7-6-9-0
 **/
extension String {
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }

    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0 + n, count)])
            if $0 + n < count {
                result += separator
            }
        }
        return result
    }
}

// MARK: Calc
extension String {

    func calculateWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func calculateHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}

// MARK: NS (Old project)
extension String {

    func thickenText(rangeStringArrayWithColor: [(String, UIColor)], font: UIFont) -> NSMutableAttributedString {
        let str = NSString(string: self)
        let attributedString = NSMutableAttributedString(string: self)

        rangeStringArrayWithColor.forEach { selectedString, selectedColor in
            let selectedRange = str.range(of: selectedString)
            attributedString.addAttributes([NSAttributedString.Key.font: font as Any, NSAttributedString.Key.foregroundColor: selectedColor], range: selectedRange)
        }
        return attributedString
    }

    func getAttributedStringWithBoldTextBetweenSpecialCharacters(specialCharacter: Character,
                                                                 boldTextFont: UIFont,
                                                                 boldTextColor: UIColor) -> NSMutableAttributedString {
        var indexOfSpecialCharacter: [Int] = []
        var counter = 0
        self.forEach {
            $0 == specialCharacter ? indexOfSpecialCharacter.append(counter) : nil
            counter += 1
        }

        if indexOfSpecialCharacter.isEmpty { return NSMutableAttributedString(string: self) }

        let finalIndexOfSpecialCharacter = indexOfSpecialCharacter.count - (indexOfSpecialCharacter.count % 2)

        var selectedTexts: [(String, UIColor)] = []
        for i in stride(from: 0, to: finalIndexOfSpecialCharacter - 1, by: 2) {
            let start = self.index(self.startIndex, offsetBy: indexOfSpecialCharacter[i])
            let end = self.index(self.startIndex, offsetBy: indexOfSpecialCharacter[i + 1])
            let range = start...end
            let selectedText = String(self[range]).replacingOccurrences(of: String(specialCharacter), with: "")
            selectedTexts.append((selectedText, boldTextColor))
        }

        let edittedText = self.replacingOccurrences(of: String(specialCharacter), with: "")

        let attributedText = edittedText.thickenText(rangeStringArrayWithColor: selectedTexts, font: boldTextFont)
        return attributedText
    }
}
