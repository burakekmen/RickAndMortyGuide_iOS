//
//  LanguageBookComponentsExtensions.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit

// MARK: Label
extension UILabel {

    func makeLocalizeText(_ key: GeneralLocalizeKeys) {
        text = key.make()
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param: String) {
        text = key.make(param: param)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String) {
        text = key.make(param1: param1, param2: param2)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) {
        text = key.make(param1: param1, param2: param2, param3: param3)
    }
}

// MARK: Button
extension UIButton {

    func makeLocalizeText(_ key: GeneralLocalizeKeys, forState: UIControl.State = []) {
        setTitle(key.make(), for: forState)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param: String, forState: UIControl.State = []) {
        setTitle(key.make(param: param), for: forState)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String, forState: UIControl.State = []) {
        setTitle(key.make(param1: param1, param2: param2), for: forState)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String, forState: UIControl.State = []) {
        setTitle(key.make(param1: param1, param2: param2, param3: param3), for: forState)
    }
}

// MARK: UITextField
extension UITextField {

    // Text
    func makeLocalizeText(_ key: GeneralLocalizeKeys) {
        text = key.make()
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param: String) {
        text = key.make(param: param)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String) {
        text = key.make(param1: param1, param2: param2)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) {
        text = key.make(param1: param1, param2: param2, param3: param3)
    }

    // Placeholder
    func makeLocalizePlaceholder(_ key: GeneralLocalizeKeys) {
        placeholder = key.make()
    }

    func makeLocalizePlaceholder(_ key: GeneralLocalizeKeys, param: String) {
        placeholder = key.make(param: param)
    }

    func makeLocalizePlaceholder(_ key: GeneralLocalizeKeys, param1: String, param2: String) {
        placeholder = key.make(param1: param1, param2: param2)
    }

    func makeLocalizePlaceholder(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) {
        placeholder = key.make(param1: param1, param2: param2, param3: param3)
    }
}

// MARK: UITextView
extension UITextView {

    func makeLocalizeText(_ key: GeneralLocalizeKeys) {
        text = key.make()
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param: String) {
        text = key.make(param: param)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String) {
        text = key.make(param1: param1, param2: param2)
    }

    func makeLocalizeText(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) {
        text = key.make(param1: param1, param2: param2, param3: param3)
    }
}


// MARK: BarButtonItem
extension UIBarButtonItem {

    convenience init(titleKey: GeneralLocalizeKeys, style: UIBarButtonItem.Style, target: Any?, action: Selector?) {
        self.init(title: titleKey.make(), style: style, target: target, action: action)
    }

    convenience init(titleKey: GeneralLocalizeKeys, style: UIBarButtonItem.Style, handler: ((UIBarButtonItem) -> Void)? = nil) {
        self.init(title: titleKey.make(), style: style, handler: handler)
    }

//    convenience init(key: GeneralLocalizeKeys, image: UIImage? = nil, primaryAction: UIAction? = nil, menu: UIMenu? = nil) {
//        if #available(iOS 14.0, *) {
//            self.init(title: key.make(), image: image, primaryAction: primaryAction, menu: menu)
//        }
//    }

    func makeLocalizeTitle(_ key: GeneralLocalizeKeys) {
        title = key.make()
    }

    func makeLocalizeTitle(_ key: GeneralLocalizeKeys, param: String) {
        title = key.make(param: param)
    }

    func makeLocalizeTitle(_ key: GeneralLocalizeKeys, param1: String, param2: String) {
        title = key.make(param1: param1, param2: param2)
    }

    func makeLocalizeTitle(_ key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) {
        title = key.make(param1: param1, param2: param2, param3: param3)
    }
}

// MARK: UIAlertAction
extension UIAlertAction {

    convenience init(titleKey: GeneralLocalizeKeys, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: titleKey.make(), style: style, handler: handler)
    }
}
