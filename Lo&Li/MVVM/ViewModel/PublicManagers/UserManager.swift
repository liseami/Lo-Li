//
//  userManager.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/7/15.
//

import Foundation

// MARK: - 用户管理

class UserManager: ObservableObject {
    private let UserDiskCacheFileName = "currentUser"
    static let shared = UserManager()
    let userDefaults = UserDefaults.standard
    var deviceToken = ""

    init() {
        if let userInfo = UserInfo.getForDisk(fileName: UserDiskCacheFileName) {
            locUser = userInfo
        } else {
            locUser = .init()
        }
        // token
//        AccessToken = userDefaults.string(forKey: "accessToken") ?? ""
//        // 已购产品id数组
//        PrivacyAgreementRead = userDefaults.bool(forKey: "PrivacyAgreementRead")
//        if logged { Task { await self.getuserprofileinfo() }}
    }

    var locUser: UserInfo {
        didSet {
            // 磁盘缓存
            locUser.cacheOnDisk(fileName: UserDiskCacheFileName)
            objectWillChange.send()
        }
    }

    /*
     Token缓存
     */

    @AppStorage("PrivacyAgreementRead") var PrivacyAgreementRead: Bool = false
    @AppStorage("AccessToken") var AccessToken: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}

extension UserManager {
    // 是否登录
    var logged: Bool {
        let logged = !AccessToken.isEmpty
        if !logged { BackToTop(animated: true) }
        return logged
    }
}
