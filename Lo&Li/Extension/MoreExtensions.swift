//
//  Ex.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/23.
//  测试同步,xixi

import Foundation
import StoreKit
import SwiftUI
import UIKit

extension UIApplication {
    // 获取顶级试图
    // ...
    // ...
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter(\.isKeyWindow).first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

public extension UINavigationController {
    override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

/// 价格本地化
public extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        if let str = formatter.string(from: price) {
            return str
        } else {
            return "价格异常..."
        }
    }

    var HeightPriceString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        let heightprice = price.multiplying(by: NSDecimalNumber(value: 1.618 * 3))
        if let str = formatter.string(from: heightprice) {
            return str
        } else {
            return "价格异常..."
        }
    }
}
