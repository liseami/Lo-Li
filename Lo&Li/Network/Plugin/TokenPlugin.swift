//
//  TokenPlugin.swift
//  FantasyUI
//
//  Created by 赵翔宇 on 2022/3/14.
//

import Foundation
import Moya
public class TokenPlugin: PluginType {
    public init() {}
    public func didReceive(_ result: Result<Response, MoyaError>, target _: TargetType) {
        if result.messageCode == 4001 {
            pushPop("登录已过期，请重新登录。", style: .warning, alignment: .top)
            mada(.error)
        }
    }
}
