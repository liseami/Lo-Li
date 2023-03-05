//
//  Data+++.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/3/23.
//

import CryptoKit
import Foundation

extension Data {
    var md5: String {
        Insecure.MD5
            .hash(data: self)
            .map { String(format: "%02x", $0) }
            .joined()
    }

    func parameterString() -> String {
        guard let json = try? JSONSerialization.jsonObject(with: self),
              let value = json as? [String: Any]
        else {
            return ""
        }
        return "\(value)"
    }
}


