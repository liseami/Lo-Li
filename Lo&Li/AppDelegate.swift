//
//  App.swift
//  TimeMachine (iOS)
//
//  Created by Liseami on 2021/10/1.
//


@_exported import Combine
@_exported import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        unlockPow(reason: .iDidBuyTheLicense)
        AppInitManager.shared.setup()
        return true
    }

    // 用户同意通知
    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }
}
