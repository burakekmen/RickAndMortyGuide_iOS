//
//  String+DateFormats.swift
//  RickAndMortyGuide
//
//  
//

import Foundation

extension String {

    // "yyyy-MM-dd'T'HH:mm:ss"
    // for manual -> yyyy-MM-ddTHH:mm:ss
    func getApiResponseTypeDate() -> Date? {
        let format = "yyyy-MM-ddTHH:mm:ss"
        let formatCount = format.count
        let sub = self[0..<formatCount]
        return DateFormatHelper.createFormatterApiResponseType().date(from: sub)
    }

    // "dd.MM.yyyy"
    func dateFormatToAppDisplayType() -> String? {
        if let date = getApiResponseTypeDate() {
            return DateFormatHelper.createFormatterAppDisplayType().string(from: date)
        }
        return nil
    }

    // "HH:mm"
    func timeFormatHourMinute() -> String? {
        if let date = getApiResponseTypeDate() {
            return DateFormatHelper.createFormatterHourMinute().string(from: date)
        }
        return nil
    }

    // "yyyy-MM-dd"
    func dateFormatToApiRequestType() -> String? {
        if let date = getApiResponseTypeDate() {
            return DateFormatHelper.createFormatterApiRequestType().string(from: date)
        }
        return nil
    }

    // dd MMMM yyyy HH:mm
    func dateTimeFormatFull() -> String? {
        if let date = getApiResponseTypeDate() {
            return DateFormatHelper.createFormatterDateTime().string(from: date)
        }
        return nil
    }

    func dateFormatMonthYear() -> String? {
        if let date = getApiResponseTypeDate() {
            return DateFormatHelper.createFormatterMonthYear().string(from: date).upperCasedTR()
        }
        return nil
    }

}
