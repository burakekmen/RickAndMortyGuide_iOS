//
//  String+Localizable.swift
//  RickAndMortyGuide
//
//  
//

import Foundation
import UIKit

//extension String {
//
//    var currentDeviceLanguage: String? {
//        let preferredLanguage = Locale.preferredLanguages[0] as String
//        let arr = preferredLanguage.components(separatedBy: "-")
//        if let deviceLanguage = arr.first {
//            if deviceLanguage == "tr" || deviceLanguage == "en" {
//                return deviceLanguage
//            }
//        }
//        return nil
//    }
//
//    var userSelectedLanguage: String? {
//        return "tr"
//    }
//
//    var currentLanguageBundlePath: Bundle {
//        let selectedLanguage = (userSelectedLanguage ?? currentDeviceLanguage) ?? "tr"
//        let bundlePath = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")!
//        return Bundle(path: bundlePath)!
//    }
//
//}
//
//protocol Localizable {
//    var localized: String { get }
//}
//
//extension String: Localizable {
//
//    func localized() -> String {
//        return NSLocalizedString(self, tableName: nil, bundle: currentLanguageBundlePath, comment: "")
//    }
//
//    func localized(arguments: CVarArg...) -> String {
//        return String.localizedStringWithFormat(NSLocalizedString(self, bundle: currentLanguageBundlePath, comment: ""), arguments)
//    }
//}
//
//
//func abc() {
//    let label  = UILabel()
//    label.text = "sr".localized(1,"burak")
//    let fruitName = NSLocalizedString("apple", comment: "")
//    let availableAmount = 3
//    print(String.localizedStringWithFormat(NSLocalizedString("Number of %@ available: %d", bundle: bundle, comment: ""), fruitName, availableAmount))
//}
