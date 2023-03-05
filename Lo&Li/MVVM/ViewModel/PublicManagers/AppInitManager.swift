//
//  AppInitManager.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/18.
//

import Foundation
import Kingfisher

class AppInitManager {
    static let shared: AppInitManager = .init()
    func setup() {
        KingFisherSetup() // Kingfisher 设置
        UISetup() // UI设置
        NotificationSet() // 通知设置
        
        // guard UserManager.shared.PrivacyAgreementRead else { return }
        // AMapSetup()
        // AppStoreInit() // 应用内购买设置
    }


    private func NotificationSet() {
        // 首先需要初始化LeanCloud应用
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            // 同意通知
            case .authorized:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            // 不同意通知，请求通知
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { granted, _ in
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            default:
                break
            }
        }
    }

    private func UISetup() {
        // ▼ 清除通知红点
        UIApplication.shared.applicationIconBadgeNumber = -1
        // ▼ UI调整
        CustomUIAppearance()
    }

//    private func AppStoreInit() {
//        _ = StoreManager()
//    }

    /// KingFisher配置
    private func KingFisherSetup() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024
        cache.memoryStorage.config.countLimit = 30
        cache.memoryStorage.config.expiration = .seconds(600)
        cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
        cache.diskStorage.config.expiration = .never
    }
}
