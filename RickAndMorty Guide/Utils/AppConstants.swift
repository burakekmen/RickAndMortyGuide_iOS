//
//  AppConstants.swift
//  RickAndMortyGuide
//
//

import Foundation

struct AppConstants {

    private init() { }
    
    static let APP_STORE_URL = ""

    // MARK: Intervals In Seconds
    static func toMinuteInSeconds() -> Double { return 60 }
    static func toHourInSeconds() -> Double { return 3600 }
    static func toDayInSeconds() -> Double { return 86400 }
    static func toWeekInSeconds() -> Double { return 604800 }
    static func toYearInSeconds() -> Double { return 31556926 }

    struct RemoteConfigKey {
        // static let ios_app_in_review = "ios_app_in_review"
    }
}
