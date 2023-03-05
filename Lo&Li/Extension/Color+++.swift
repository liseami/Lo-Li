//
//  Color+++.swift
//  Looper
//
//  Created by 赵翔宇 on 2022/6/24.
//

import Foundation

public extension Color {
    // hex Color
    init(hex: String) {
        let scanner = Foundation.Scanner(string: hex)
        scanner.currentIndex = hex.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            .sRGB,
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff
        )
    }

    /*
     返回辅色
     */
    func complementaryColor() -> Color {
        return Color(UIColor(self).complementary ?? .clear)
    }

    // 是否过于亮
     func isLight() -> Bool {
        guard let components = UIColor(self).cgColor.components, components.count > 2 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return (brightness > 0.5)
    }

    // 随机颜色
    static func random() -> Color {
        Color(uiColor: UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0
        ))
    }
    
    
    // 从UIColor返回Color
    public init(uiColor: UIColor) {
        let components = uiColor.cgColor.components!
        self.init(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]), opacity: Double(components[3]))
    }
}

// MARK: 检测是否颜色过于亮

extension CGFloat {
    static func random() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
