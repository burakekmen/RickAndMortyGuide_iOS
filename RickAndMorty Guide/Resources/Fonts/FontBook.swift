//
//  FontBook.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 26.05.2022.
//

import UIKit

protocol Fontable {
    var family: String { get }
    var style: String { get }
    var fontExtension: String { get }
    func of(size: CGFloat) -> UIFont
}

extension Fontable {
    func of(size: CGFloat = 12) -> UIFont {
        return UIFont(name: "Misfits", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

public struct FontBook {

    // SFProText
    enum SFProText: String, Fontable {

        var family: String {
            return "Misfits"
        }

        var style: String {
            return self.rawValue
        }

        var fontExtension: String {
            return "ttf"
        }

        case Regular
    }
}

// MARK: UIFont Extension
extension UIFont {

    // MARK: Sf Pro Text
    static func fontRickAndMorty(size: CGFloat = 12) -> UIFont {
        return .fontSFProText(type: .Regular, size: size)
    }

    static func fontSFProText(type: FontBook.SFProText, size: CGFloat = 12) -> UIFont {
        return type.of(size: size)
    }
//    static func fontSFProTextSemiBold(size: CGFloat = 12) -> UIFont {
//        return .fontSFProText(type: .Semibold, size: size)
//    }
//
//    static func fontSFProTextMedium(size: CGFloat = 12) -> UIFont {
//        return .fontSFProText(type: .Medium, size: size)
//    }
//
//    static func fontSFProTextRegular(size: CGFloat = 12) -> UIFont {
//        return .fontSFProText(type: .Regular, size: size)
//    }
//
//    static func fontSFProTextLight(size: CGFloat = 12) -> UIFont {
//        return .fontSFProText(type: .Light, size: size)
//    }
}
