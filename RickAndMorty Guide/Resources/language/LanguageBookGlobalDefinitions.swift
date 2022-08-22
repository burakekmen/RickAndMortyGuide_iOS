//
//  LanguageBookGlobalDefinitions.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import Foundation

// heryerden erişilebilir olsunlar diye direk global funcs olarak tanımladık.

func fetchLocalizeString(key: GeneralLocalizeKeys) -> String {
    return key.make()
}

func fetchLocalizeString(key: GeneralLocalizeKeys, param: String) -> String {
    return key.make(param: param)
}

func fetchLocalizeString(key: GeneralLocalizeKeys, param1: String, param2: String) -> String {
    return key.make(param1: param1, param2: param2)
}

func fetchLocalizeString(key: GeneralLocalizeKeys, param1: String, param2: String, param3: String) -> String {
    return key.make(param1: param1, param2: param2, param3: param3)
}
