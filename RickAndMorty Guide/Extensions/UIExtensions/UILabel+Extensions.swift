//
//  UILabel+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

struct DidTapRangeTextModel {
    let rangeText: String
    let didTap: ((CGPoint) -> Void)
}

extension UILabel {

    // certainText ile orjinalText aynı olunca hatalı çalışıyor.
    func changeAttributedFontAndColor(certainText: String, font: UIFont, color: UIColor) {
        guard let selfText = self.text else { fatalError("label.text is cannot empty") }

        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = selfText.findRangeOf(certainText: certainText)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: rangeOfString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: rangeOfString)

        self.attributedText = attributedString
    }

    // certainText ile orjinalText aynı olunca hatalı çalışıyor.
    func changeAttributedFont(certainText: String, font: UIFont) {
        guard let selfText = self.text else { fatalError("label.text is cannot empty") }

        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = selfText.findRangeOf(certainText: certainText)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: rangeOfString)

        self.attributedText = attributedString
    }

    // certainText ile orjinalText aynı olunca hatalı çalışıyor.
    func changeAttributedColor(certainText: String, color: UIColor = .black) {
        guard let selfText = self.text else { fatalError("label.text is cannot empty") }

        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = selfText.findRangeOf(certainText: certainText)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: rangeOfString)

        self.attributedText = attributedString
    }

    func addTrailingImageWithText(image: UIImage?, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }

    func addLeadingImageWithText(image: UIImage?,
                                 imageSize: CGSize = .init(width: 12, height: 12),
                                 text: String,
                                 spacing: CGFloat = 5) {
        // Image
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = .init(
            x: 0,
            y: -(imageSize.height / 6),
            width: imageSize.width,
            height: imageSize.height)
        let attachmentString = NSAttributedString(attachment: attachment)

        // Spacing
        let attachmentSpacing = NSTextAttachment()
        attachmentSpacing.bounds = .init(x: 0, y: 0, width: spacing, height: 0)
        let attachmentSpacingString = NSAttributedString(attachment: attachmentSpacing)

        // Text
        let string = NSMutableAttributedString(string: text, attributes: [:])

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        mutableAttributedString.append(attachmentSpacingString)
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }

    /* func setRobotoFont(_ robotoFont: FontBook.Roboto, fontSize: CGFloat) {
        font = robotoFont.of(size: fontSize)
    } */

    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format: "<span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>" as NSString, text)

        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }

    func didTapMultipleRangeText(tapItems: [DidTapRangeTextModel]) {
        self.isUserInteractionEnabled = true
        guard let selfText = self.text else { fatalError("label.text is cannot empty") }

        self.onTap { [weak self] gesture in
            guard let strongSelf = self else { return }
            for item in tapItems {
                let range = (selfText as NSString).range(of: item.rangeText)
                let (isHave, touchPoint) = gesture.didTapAttributedTextInLabelWithLocation(label: strongSelf, inRange: range)
                if isHave {
                    item.didTap(touchPoint)
                }
            }
        }
    }

    func didTapRangeText(rangeText: String,
                         tapUnderlined: @escaping () -> Void,
                         tapOtherArea: (() -> Void)? = nil) {
        self.isUserInteractionEnabled = true
        guard let selfText = self.text else { fatalError("label.text is cannot empty") }

        self.onTap { [weak self] gesture in
            guard let strongSelf = self else { return }
            let userAggrRange = (selfText as NSString).range(of: rangeText)
            if gesture.didTapAttributedTextInLabel(label: strongSelf, inRange: userAggrRange) {
                tapUnderlined()
            } else {
                tapOtherArea?()
            }
        }
    }

    func setColorWithUnderlineRange(rangeText: String, color: UIColor) {
        guard let selfText = self.text else { fatalError("label.text is can not empty") }
        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = (selfText as NSString).range(of: rangeText, options: .caseInsensitive)
        attributedString.addAttribute(.foregroundColor, value: color, range: rangeOfString)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeOfString)

        self.attributedText = attributedString
    }

    func setColorWithUnderlineRangeList(rangeTexts: [String], color: UIColor) {
        guard let selfText = self.text else { fatalError("label.text is can not empty") }
        let attributedString = NSMutableAttributedString(string: selfText)

        for item in rangeTexts {
            let rangeOfString = (selfText as NSString).range(of: item, options: .caseInsensitive)
            attributedString.addAttribute(.foregroundColor, value: color, range: rangeOfString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeOfString)
        }

        self.attributedText = attributedString
    }

    func setColorRange(rangeText: String, color: UIColor) {
        guard let selfText = self.text else { fatalError("label.text is can not empty") }
        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = (selfText as NSString).range(of: rangeText, options: .caseInsensitive)
        attributedString.addAttribute(.foregroundColor, value: color, range: rangeOfString)

        self.attributedText = attributedString
    }

    func setUnderlinedRange(rangeText: String) {
        guard let selfText = self.text else { fatalError("label.text is can not empty") }

        let attributedString = NSMutableAttributedString(string: selfText)

        let rangeOfString = (selfText as NSString).range(of: rangeText, options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeOfString)

        self.attributedText = attributedString
    }

    func getContentSize() -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        let attributes: [NSAttributedString.Key: AnyObject] = [
                .font: self.font,
                .paragraphStyle: paragraphStyle]
        let contentSize: CGSize = self.text!.boundingRect(
            with: self.frame.size,
            options: ([.usesLineFragmentOrigin, .usesFontLeading]),
            attributes: attributes,
            context: nil
        ).size
        return contentSize
    }
}

// MARK: Old Projects
extension UILabel {

    func underlineText(rangeStringArray: [String],
                       multiColorArray: [UIColor]? = nil,
                       underlinedFont: UIFont,
                       underlinedColor: UIColor? = nil) {
        
        if let textString = self.text {
            let str = NSString(string: textString)
            let attributedString = NSMutableAttributedString(string: textString)

            if let controledMultiColor = multiColorArray {
                for counter in 0...controledMultiColor.count - 1 {
                    let specificColor = controledMultiColor[counter]
                    let selectedRange = str.range(of: rangeStringArray[counter])
                    attributedString.addAttributes([NSAttributedString.Key.font: underlinedFont as Any, NSAttributedString.Key.foregroundColor: specificColor], range: selectedRange)
                }
            } else {
                guard let controledSingleColor = underlinedColor else { return }
                for range in rangeStringArray {
                    let selectedRange = str.range(of: range)
                    attributedString.addAttributes([NSAttributedString.Key.font: underlinedFont as Any, NSAttributedString.Key.foregroundColor: controledSingleColor], range: selectedRange)
                }
            }
            attributedText = attributedString
        }
    }
}
