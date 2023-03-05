//
//  Date+++.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/3/20.
//

import Foundation

public extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    var timestamp: Int {
        Int(timeIntervalSince1970)
    }

    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter
        dateFormatter.locale = NSLocale(localeIdentifier: "zh-hans") as Locale
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    var year: Int { Calendar.current.dateComponents([.year], from: self).year ?? 0
    }

    var millisecondsSince1970: Int {
        Int((timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }

    // 定义一个函数，接受一个日期对象并返回它是当年的第几天
    var dayOfYear: Int {
        // 创建一个日历对象
        let calendar = Calendar.current

        // 使用日历对象的dateComponents方法获取日期对象中的年份、月份和日
        let components = calendar.dateComponents([.year, .month, .day], from: self)

        // 获取年份、月份和日
        let year = components.year!
        let month = components.month!
        let day = components.day!

        // 计算当前月份之前的天数
        let daysInMonthsBeforeCurrent = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
        let daysBeforeCurrentMonth = daysInMonthsBeforeCurrent[month - 1]

        // 计算当前日是当年的第几天
        var dayOfYear = daysBeforeCurrentMonth + day

        // 如果当前日期是二月份且是闰年，需要再加上一天
        if month == 2, isLeapYear {
            dayOfYear += 1
        }

        return dayOfYear
    }

    // 判断当前日期是否是闰年
    var isLeapYear: Bool {
        // 获取当前日期的年份
        let year = Calendar.current.component(.year, from: self)

        // 如果是闰年，返回true，否则返回false
        if year % 400 == 0 {
            return true
        }
        if year % 100 == 0 {
            return false
        }
        if year % 4 == 0 {
            return true
        }
        return false
    }
}
