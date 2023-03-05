//
//  UIImage.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/2/21.
//

import Foundation

extension UIImage {}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

    func toBase64String() -> String {
        let data = self.jpegData(compressionQuality: 1)
        let base64Str = data?.base64EncodedString(options: .lineLength64Characters) ?? ""
        let iamgeBase64str = base64Str.isEmpty ? "" : base64Str
        return iamgeBase64str
    }
}
