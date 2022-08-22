//
//  NSMutableAttributedString+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

extension NSMutableAttributedString {

    var rangeFull: NSRange {
        return .init(location: 0, length: self.string.count)
    }

    func addLineSpacing(value: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = value
        addAttribute(.paragraphStyle, value: paragraphStyle, range: self.rangeFull)
        return self
    }

    func addStrikethroughStyle() -> NSMutableAttributedString {
        addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: self.rangeFull)
        return self
    }

    func applyAttributeFontAndColor(certainText: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        if certainText.count > 0 {
            let rangeOfText = string.findRangeOf(certainText: certainText)
            _ = addAttributeFont(font, range: rangeOfText)
            _ = addAttributeForegroundColor(color, range: rangeOfText)
        }
        return self
    }

    func addAttributeFont(certainText: String, font: UIFont) -> NSMutableAttributedString {
        if certainText.count > 0 {
            let rangeOfText = string.findRangeOf(certainText: certainText)
            return addAttributeFont(font, range: rangeOfText)
        }

        return self
    }


    func addAttributeFont(_ font: UIFont, range: NSRange) -> NSMutableAttributedString {
        addAttribute(.font, value: font, range: range)
        return self
    }

    func addAttributeForegroundColor(certainText: String, color: UIColor) -> NSMutableAttributedString {
        if certainText.count > 0 {
            let rangeOfText = string.findRangeOf(certainText: certainText)
            return addAttributeForegroundColor(color, range: rangeOfText)
        }
        return self
    }

    func addAttributeForegroundColor(_ color: UIColor, range: NSRange) -> NSMutableAttributedString {
        addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
    func addAttributeUnderlineFull() -> NSMutableAttributedString {
        return addAttributeUnderline(range: rangeFull)
    }

    func addAttributeUnderline(certainText: String) -> NSMutableAttributedString {
        if certainText.count > 0 {
            let rangeOfText = string.findRangeOf(certainText: certainText)
            return addAttributeUnderline(range: rangeOfText)
        }

        return self
    }

    func addAttributeUnderline(range: NSRange) -> NSMutableAttributedString {
        addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        return self
    }
    
    func addAttributeBuilder(_ name: NSAttributedString.Key, value: Any, range: NSRange) -> NSMutableAttributedString {
        addAttribute(name, value: value, range: range)
        return self
    }

}
