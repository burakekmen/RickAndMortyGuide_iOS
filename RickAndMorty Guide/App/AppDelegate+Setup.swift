//
//  AppDelegate+Setup.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

// MARK: Base UI Config
internal extension AppDelegate {

}

internal extension AppDelegate {

    func initAlamofireNetworkLogger() {
        AlamofireNetworkLogger.shared.startLogging()
        AlamofireNetworkLogger.shared.level = .debug
    }

    func initLocalize() {
        // Localize
        let localize = Localize.shared
        localize.update(provider: .json)
        localize.update(fileName: "lang")

        if let language = AppManager.shared.getAppLanguage() { // kullanıcının seçtiği ve lokale kaydettiğimiz dil
            localize.update(defaultLanguage: language)
            localize.update(language: language.lowercased())
        } else {
            let preferredLanguage = Locale.preferredLanguages[0] as String // telefon dili
            let arr = preferredLanguage.components(separatedBy: "-")
            let deviceLanguage = arr.first
            localize.update(defaultLanguage: deviceLanguage!)
            localize.update(language: deviceLanguage!.lowercased())
            AppManager.shared.setAppLanguage(language: deviceLanguage ?? "en")
        }
    }

    func initIQKeyboardManager() {
        // IQKeyboardManager
        let keyboardSharedManager = IQKeyboardManager.shared
        keyboardSharedManager.enable = true
        keyboardSharedManager.toolbarDoneBarButtonItemText = GeneralLocalizeKeys.str_close.make()
        keyboardSharedManager.shouldResignOnTouchOutside = true

        /*  if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            keyboardSharedManager.toolbarTintColor = UIColor.white
        } else {
            keyboardSharedManager.toolbarTintColor = .green // değişecek
        } */
    }

}

