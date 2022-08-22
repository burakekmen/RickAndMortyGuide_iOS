//
//  Date+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension Date {

    /// Convert NSDate to Millisecond
    static var toMilliseconds: TimeInterval {
        get { return Date().timeIntervalSince1970 * 1000 }
    }
}

extension Date {

    // "yyyy-MM-dd"
    func dateFormatToApiRequestType() -> String {
        return DateFormatHelper.createFormatterApiRequestType().string(from: self)
    }

    // "dd.MM.yyyy"
    func dateFormatToAppDisplayType() -> String {
        return DateFormatHelper.createFormatterAppDisplayType().string(from: self)
    }

    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)

        return abs(components.day ?? 0)
    }
}

