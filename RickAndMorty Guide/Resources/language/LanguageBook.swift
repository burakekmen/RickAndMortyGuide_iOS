//
//  LanguageBook.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 19.05.2022.
//

import UIKit
import Localize

typealias GeneralLocalizeKeys = LanguageBook.General

protocol Languageable {
    var rawLocalizeString: String { get }
}

extension Languageable {

    func make() -> String {
        return self.rawLocalizeString.localize()
    }

    func make(param: String) -> String {
        return self.rawLocalizeString.localize(value: param, tableName: nil)
    }

    func make(param1: String, param2: String) -> String {
        return self.rawLocalizeString.localize(values: param1, param2, tableName: nil)
    }

    func make(param1: String, param2: String, param3: String) -> String {
        return self.rawLocalizeString.localize(values: param1, param2, param3, tableName: nil)
    }
}

struct LanguageBook {

    enum General: String, Languageable {

        internal var rawLocalizeString: String {
            return self.rawValue
        }

        case str_empty = ""
        case str_app_name
        case str_success
        case str_warning
        case str_error
        case str_ok
        case str_cancel
        case str_vazgec
        case str_close
        case str_back
        case str_please_check_your_network_connection
        case str_characters
        case str_favorites
        case str_episodes
        case str_commonErrorMesage
        case str_serverErrorMessage
        case str_undefinedResponseMessage
        case str_information
        case str_character_detail_page_navigation_title
        case str_episode_detail_page_navigation_title
    }
}
