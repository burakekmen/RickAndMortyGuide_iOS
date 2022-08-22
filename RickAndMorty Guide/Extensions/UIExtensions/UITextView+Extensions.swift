//
//  UITextView+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension UITextView {

    func limitationDigitForNumber(range: NSRange, string: String, maxLength: Int) -> Bool {
        let inverseSet = CharacterSet(charactersIn: "+0123456789()").inverted

        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")

        return string == filtered
            && setMaxLengthShouldChangeCharactersIn(range: range, string: string, maxLength: maxLength)
    }

    func setMaxLengthShouldChangeCharactersIn(range: NSRange, string: String, maxLength: Int) -> Bool {
        guard let text = self.text,
            let rangeOfTextToReplace = Range(range, in: text) else {
                return false
        }
        let substringToReplace = text[rangeOfTextToReplace]
        let count = text.count - substringToReplace.count + string.count

        return count <= maxLength
    }
}

