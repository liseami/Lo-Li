//
//  String+++.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/3/20.
//

import Foundation

extension Int {
    /// JAVA后台时间戳转换为前端UI中的Modd发布时间信息
    /// - Returns: Mood发布时间字符串
    func timeToNow_Java() -> String {
        let now = Int(Date().timeIntervalSince1970)
        let java_timestamp = self / 1000
        let elapsedSeconds = now - java_timestamp
        let elapsedMinutes = elapsedSeconds / 60
        let elapsedHours = elapsedMinutes / 60
        let elapsedDays = elapsedHours / 24
        let elapsedMonths = elapsedDays / 30
        let elapsedYears = elapsedMonths / 12

        if elapsedYears > 0 {
            return java_timestamp.toDate().toString(dateFormat: "YYYY年MM月dd日")
        } else if elapsedMonths > 0 {
            return "\(elapsedMonths)个月前"
        } else if elapsedDays > 0 {
            return "\(elapsedDays)天前"
        } else if elapsedHours > 0 {
            return "\(elapsedHours)小时前"
        } else if elapsedMinutes > 0 {
            return "\(elapsedMinutes)分钟前"
        } else {
            return "刚刚"
        }
    }

    func timeToNow_Swift() -> String {
        let now = Int(Date().timeIntervalSince1970)
        let elapsedSeconds = now - self
        let elapsedMinutes = elapsedSeconds / 60
        let elapsedHours = elapsedMinutes / 60
        let elapsedDays = elapsedHours / 24
        let elapsedMonths = elapsedDays / 30
        let elapsedYears = elapsedMonths / 12

        if elapsedYears > 0 {
            return "\(elapsedYears)年前"
        } else if elapsedMonths > 0 {
            return "\(elapsedMonths)个月前"
        } else if elapsedDays > 0 {
            return "\(elapsedDays)天前"
        } else if elapsedHours > 0 {
            return "\(elapsedHours)小时前"
        } else if elapsedMinutes > 0 {
            return "\(elapsedMinutes)分钟前"
        } else {
            return "刚刚"
        }
    }

    func toDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }

    var timeLongString: String {
        guard self > 0 else {
            return "0 秒"
        }

        let elapsedSeconds = self
        let elapsedMinutes = elapsedSeconds / 60
        let elapsedHours = elapsedMinutes / 60

        if elapsedHours > 0 {
            return (elapsedMinutes % 60 == 0) ?
                "\(elapsedHours)小时" :
                "\(elapsedHours)小时\(elapsedMinutes % 60)分钟"
        } else if elapsedMinutes > 0 {
            return "\(elapsedMinutes)分钟"
        } else {
            return "\(elapsedSeconds)秒"
        }
    }

    func secToTimeStr() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let remainingSeconds = self % 60

        if hours == 0 {
            return String(format: "%02d:%02d", minutes, remainingSeconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        }
    }

    func toOClock() -> (Int, Int, Int) {
        secsToTimeOClock(secs: self)
    }
}

extension Date {
    // 转成当前时区的日期
    static func dateFromGMT(_ date: Date) -> Date {
        let secondFromGMT = TimeInterval(TimeZone(identifier: "UTC")!.secondsFromGMT(for: date))
        return date.addingTimeInterval(secondFromGMT)
    }
}
