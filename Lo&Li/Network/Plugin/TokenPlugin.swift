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
        if result.HttpCode == 401 {
            pushPop("你的Token已经失效了。", style: .warning, alignment: .top)
            UserManager.shared.AccessToken.removeAll()
            mada(.error)
        }
    }
}
