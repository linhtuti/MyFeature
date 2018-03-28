//
//  DateUtils.swift
//  Drjoy
//
//  Created by datdn1 on 8/4/17.
//  Copyright © 2017 Dr.JOY No,054. All rights reserved.
//

import Foundation

final class DateUtils {

    static let DEFAULT_FORMAT = "yyyy-MM-dd HH:mm:ss"
    static let DATE_FORMAT = "yyyy-MM-dd"
    static let POST_TODAY_FORMAT = "HH:mm"
    static let POST_YESTERDAY_FORMAT = "昨日 %01d:%02d"
    static let POST_BEFORE_YESTERDAY_FORMAT = "一昨日 %01d:%02d"
    static let POST_PASTDATE_FORMAT = "%01d月%01d日(%@) %01d:%02d"

    static let INSIDE_YEAR_FORMAT = "MM月dd日(E)"
    static let OUTSIDE_YEAR_FORMAT = "yyyy年MM月dd日(E)"
    static let DAY_FORMAT = "dd日"
    static let DAY_MONTH_FORMAT = "MM月dd日"

    static let weekdays: [String] = ["日", "月", "火", "水", "木", "金", "土"]

    static let shared = DateUtils()

    private init() {

    }

    var cachedFormater: [String: DateFormatter] = [:]

    func dateFromString(_ string: String) -> Date? {
        return dateFromString(string, format: DateUtils.DEFAULT_FORMAT)
    }

    func dateFromString(_ string: String, format: String) -> Date? {
        let formatter = formatterForFormat(format: format)
        return formatter.date(from: string)
    }

    func stringFromDate(_ date: Date) -> String {
        return stringFromDate(date, format: DateUtils.DEFAULT_FORMAT)
    }

    func formatterForFormat(format: String) -> DateFormatter {
        var formatter: DateFormatter! = nil
        if let cacheFormatter = cachedFormater[format] {
            formatter = cacheFormatter
        }
        else {
            formatter = DateFormatter()
            formatter.dateFormat = format
//            formatter.locale = Locale(identifier: "ja_JA")
//            formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
            cachedFormater[format] = formatter
        }
        return formatter
    }

    func stringFromDate(_ date: Date, format: String) -> String {
        let formatter = formatterForFormat(format: format)
        return formatter.string(from: date)
    }

    func isMatchYear(_ date: Date, target: Date) -> Bool {
        return getDateComponents(date).year == getDateComponents(target).year
    }

    func isMatchMonth(_ date: Date, target: Date) -> Bool {
        return getDateComponents(date).month == getDateComponents(target).month
    }

    func isSameDayIgnoreTime(_ date1: Date, date2: Date) -> Bool {
        return getDateWithoutTime(date1) == getDateWithoutTime(date2)
    }

    func getTodayWithoutTime(_ date: Date? = nil) -> Date? { // 引数はユニットテスト用
        let today = (date == nil) ? Date() : date
        return getDateWithoutTime(today!)
    }

    func getDateWithoutTime(_ date: Date) -> Date? {
        let comp = getDateComponents(date)
        let string = String(format: "%04d%02d%02d", comp.year!, comp.month!, comp.day!)
        return dateFromString(string, format: "yyyyMMdd")
    }

    func getDateComponents(_ date: Date) -> DateComponents {
        let calendar = Calendar.current

        return (calendar as NSCalendar).components([
            NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day,
            NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.weekday
            ], from: date)
    }

    func convertPostDateString(_ date: Date) -> String {
        var rv : String = ""
        let targetCalendar = getDateComponents(date)
        let currentDate = Date()
        if isMatchYear(date, target:currentDate) {
            if isMatchMonth(date, target:currentDate) {
                let currentCalendar = getDateComponents(currentDate)
                let diffDate = (currentCalendar.day! - targetCalendar.day!)

                switch diffDate {
                case 0:
                    rv = stringFromDate(date, format: DateUtils.POST_TODAY_FORMAT)
                case 1:
                    rv = String(format: DateUtils.POST_YESTERDAY_FORMAT,
                                targetCalendar.hour!,
                                targetCalendar.minute!
                    )

                case 2:
                    rv = String(format: DateUtils.POST_BEFORE_YESTERDAY_FORMAT,
                                targetCalendar.hour!,
                                targetCalendar.minute!
                    )
                default:
                    rv = pastDateFromPostString(date)
                }
            } else {
                rv = pastDateFromPostString(date)
            }
        } else {
            rv = pastDateFromPostString(date)
        }

        return rv;
    }

    func pastDateFromPostString(_ date : Date) -> String {
        let targetCalendar = getDateComponents(date)
        return String(format: DateUtils.POST_PASTDATE_FORMAT,
                      targetCalendar.month!,
                      targetCalendar.day!,
                      DateUtils.weekdays[targetCalendar.weekday! - 1],
                      targetCalendar.hour!,
                      targetCalendar.minute!)
    }
    
    func postTimeFormated(_ postTime: Date?) -> String {
        guard let postTime = postTime else { return "" }
        
        let dateUtils = DateUtils.shared
        
        guard let today = dateUtils.getTodayWithoutTime() else {
            return ""
        }
        guard let date = dateUtils.getDateWithoutTime(postTime) else {
            return ""
        }
        
        let td = date.timeIntervalSince(today) / (24 * 60 * 60)
        let diff: Int = abs(Int(td))
        
        switch diff {
        case 0:
            return dateUtils.stringFromDate(postTime, format: DateUtils.POST_TODAY_FORMAT)
        case 1 ..< 7:
            return dateUtils.stringFromDate(date, format: "EEEE")
        default:
            break
        }
        
        var formatter: String = DateUtils.INSIDE_YEAR_FORMAT
        if !dateUtils.isMatchYear(today, target: date) {
            formatter = DateUtils.OUTSIDE_YEAR_FORMAT
        }
        return dateUtils.stringFromDate(date, format: formatter)
    }
}
