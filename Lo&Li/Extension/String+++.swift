//
//  String+++.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/3/21.
//

import Foundation
import SwifterSwift

public extension String {
    static let data = "data"
    static let datalist = "data.list"
}

enum ImageQuality: Int {
    case MoodCardImage = 32
    case userAvatarSmall = 24
    case isImageDetail = 70
    case userAvatarLarge = 60
}

extension String {
    /// 获取修改图片质量后的URL
    /// - Parameter quality: 目标质量[0-100]
    /// - Returns:图片质量后的URL
    func ossImageQuality(quality: ImageQuality) -> String {
        self + "?x-oss-process=image/quality,q_\(quality.rawValue)"
    }
}

extension String {
    func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "").uppercased()
    }

    func isNotLetter() -> Bool {
        let upperCaseStr: String = self.uppercased()
        let c = Character(upperCaseStr)
        if c >= "A", c <= "Z" { //
            return false
        } else {
            return true
        }
    }
}

public extension String {
    func toDate(dateFormat: String) -> Date {
        let dateFormatter = DateFormatter
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }

    func isEmoji() -> Bool {
        if let c = self.first {
            return Character("\(c)").isEmoji
        } else {
            return false
        }
    }

    func or(_ or: String) -> String {
        self.isEmpty ? or : self
    }

    func ifEmptyReturenNil() -> String? {
        self.isEmpty ? nil : self
    }

    func removeA() -> String {
        self.removingPrefix("a")
    }

    func md5() -> String {
        if let data = self.data(using: .utf8) {
            let md5 = data.md5
            return md5
        } else {
            return "X7997"
        }
    }

    mutating func toggle() {
        withAnimation(.NaduoSpring) {
            self = self == "1" ? "0" : "1"
        }
    }

    func toggleString() -> String {
        self == "1" ? "0" : "1"
    }

    func getCharacterAt(_ at: Int) -> String {
        var strArray = [Character]()
        for (_, char) in self.enumerated() {
            strArray.append(char)
        }
        guard !strArray.isEmpty else { return "" }
        if strArray.count >= at + 1 {
            return String(strArray[at])
        } else {
            return ""
        }
    }
}
