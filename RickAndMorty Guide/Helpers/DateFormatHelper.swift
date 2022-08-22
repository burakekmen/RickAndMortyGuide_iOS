//
//  DateFormatHelper.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Foundation

struct DateFormatHelper {

    private init() { }

    static func createFormatterApiRequestType() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    static func createFormatterAppDisplayType() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }

    static func createFormatterApiResponseType() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }

    static func createFormatterHourMinute() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    static func createFormatterDateTime() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.TR
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        return formatter
    }

    static func createFormatterMonthYear() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.TR
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }


    /* Verilen tarih ile şimdiki tarihi karşılaştırıp ilgili dönüşleri sağlar */
    /* static func displayNowDateOrDayDiffFormatWithHourMinute(stringDate: String?) -> String? {
        if let date = stringDate?.getApiResponseTypeDate() {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            calendar.locale = Locale.TR
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second,], from: Date())
            components.hour = 0
            components.minute = 0
            components.second = 0

            if let nowDate = calendar.date(from: components) {
                let timeFormat = createFormatterHourMinute().string(from: date)
                let strToday = "str_today".localize()
                let strYesterday = "str_yesterday".localize()

                if nowDate < date {
                    return "\(strToday) \(timeFormat)"
                } else if ((nowDate.timeIntervalSince1970 - 86400) < date.timeIntervalSince1970) {
                    return "\(strYesterday) \(timeFormat)"
                } else {
                    return createFormatterDateTime().string(from: date)
                }
            }

        }
        return nil
    } */

}
