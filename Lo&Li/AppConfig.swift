//
//  AppConfig.swift
//  Looper
//
//  Created by 赵翔宇 on 2022/6/20.
//

import Foundation

public enum AppConfig {
    public static let env = Env.prod
    // 环境
    public enum Env {
        case dev
        case prod
    }

    // baseURL
    static var baseUrl: String {
        switch env {
        case .dev: return "https://api.openai.com"
        case .prod: return "https://api.openai.com"
        }
    }

    static var pollingInterval: Double {
        switch env {
        case .dev: return 20
        case .prod: return 1
        }
    }

    // 首页刷新时间间隔
    static var timeInputInterval: Int {
        switch env {
        case .dev: return 1
        case .prod: return 10
        }
    }

    public static let jiguangAppKey : String = "9f98444a6127a4f433267323"
    
    public static let mapBoxPublicToken: String = "pk.eyJ1IjoibGlzZWFtaSIsImEiOiJjbDMxNTdpeXowNmJnM2tsYzY1czc1MTdvIn0.im37nUcD6Ue66pAx0fY2vg"
    // 黄金高度44
    public static let GoldenHeight: CGFloat = 44
    // 用户协议
    public static let UserAgreement: String = "https://me.revome.cn/articles/UserAgreement/"
    // 隐私政策
    public static let UserPrivacyPolicy: String = "https://me.revome.cn/articles/UserPrivacyPolicy/"
    // 高德地图Key
    public static let AMapApiKey: String = "797597640187f008e918a8fd86849200"
    // 更新项数组
    public static let NewVersionNotes: [String] = ["1,修复邮件发送bug，尽快给我发邮件。", "2,修复事件编辑bug-感谢B站用户第三个椰子。3,更新了永久会员的纪念卡片。"]
    // 当前版本
    public static var AppVersion: String { (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "0.0.0" }
    // AppID
    public static var AppleStoreAppID: String { "6444640823" }
    // 商店链接
    public static var ProductURL: URL { URL(string: "https://apps.apple.com/cn/app/id" + AppleStoreAppID)! }
    // 测试图片
    public static var mokImage: URL? {
        let int = Int.random(in: 180 ... 220)
        return URL(string: "https://picsum.photos/\(int)/\(int)")
    }
}
