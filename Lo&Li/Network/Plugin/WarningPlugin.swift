//
//  WarningPlugin.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/1.
//

import Foundation
import Moya

/// 通用网络插件
public class WarningPlugin: PluginType {
    /// 开始请求字典

    public init() {}

    /// 即将发送请求
    public func willSend(_: RequestType, target: TargetType) {
        #if DEBUG
            // 设置当前时间

        #endif
    }

    /// 收到请求时
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success:
            if result.HttpCode != 200 &&  result.HttpCode != 400{
                pushPop(result.message.or("未知错误，请稍后再试，或联系客服。"), style: .warning, alignment: .top)
            }
            if result.HttpCode == 400 {
                pushPop(result.message.or("请先登录账号。"), style: .warning, alignment: .top)
            }
        case let .failure(error):
            pushPop(error.errorDescription ?? "登录失效。", style: .danger, alignment: .top)
        }
    }
}

/// 网络状态协议
protocol NetworkStatusProtocol {
    func isReachable() -> Bool
}

extension NetworkStatusProtocol {
    /// 返回一个布尔值,用于实时监测网络状态
    func isReachable() -> Bool {
        var res = false
        let netManager = NetworkReachabilityManager()
        if netManager?.status == .reachable(.ethernetOrWiFi) || netManager?.status == .reachable(.cellular) { res = true }
        return res
    }
}
