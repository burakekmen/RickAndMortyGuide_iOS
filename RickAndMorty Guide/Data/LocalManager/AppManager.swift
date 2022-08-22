//
//  AppManagert.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 21.05.2022.
//

import Foundation

class AppManager {

    static let shared = AppManager()

    var defaults: Defaults? = nil

    private init() {
        defaults = Defaults()
    }

    /**
     * App First Open
     * */
    public func setFirstOpenApp(value: Bool) {
        defaults?.set(value, for: .firstOpenAppObject)
    }

    public func isFirstOpenApp() -> Bool {
        return defaults?.get(for: .firstOpenAppObject) ?? false
    }

    public func removeFirstOpenApp() {
        defaults?.clear(.firstOpenAppObject)
    }
    
    //MARK: App Language
    public func getAppLanguage() -> String? {
        return defaults?.get(for: .appLanguageAppObject)
    }
    
    public func setAppLanguage(language: String) {
        defaults?.set(language, for: .appLanguageAppObject)
    }
}

private extension DefaultsKey {
    static let firstOpenAppObject = Key<Bool>("FirstOpenAppObject")
    static let appLanguageAppObject = Key<String>("AppLanguageAppObject")
}


