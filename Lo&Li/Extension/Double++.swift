//
//  Double++.swift
//  Looper
//
//  Created by 赵翔宇 on 2022/6/24.
//

import Foundation

public extension Double {
    var toCurrencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let str = formatter.string(from: NSNumber(value: self))!
        return str
    }
}
