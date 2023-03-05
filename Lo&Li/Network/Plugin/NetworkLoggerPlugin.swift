//
//  NetworkPlugin.swift
//  fenJianXiao_iOS
//
//  Created by liangze on 2019/12/17.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya

/// 通用网络插件
public class NetworkingLogger: PluginType, NetworkStatusProtocol {
    /// 开始请求字典
    private static var startDates: [String: Date] = [:]

    public init() {}

    /// 即将发送请求
    public func willSend(_: RequestType, target: TargetType) {
        #if DEBUG
            // 设置当前时间
            NetworkingLogger.startDates[String(describing: target)] = Date()
        #endif
    }

    /// 收到请求时
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
            guard let startDate = NetworkingLogger.startDates[String(describing: target)] else { return }
            // 获取当前时间与开始时间差（秒数）
            let requestDate = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970

            print("🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢\(target.path)🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢")
            if let url = result.rawReponse?.request?.url?.absoluteString {
                print("URL : \(url)")
            } else {
                print("URL : \(target.baseURL)\(target.path)")
            }
            print("请求方式：\(target.method.rawValue)")
            print("请求时间 : \(String(format: "%.3f", requestDate))s")
            if let token = target.headers?["token"] {
                let start = String(token.prefix(7))
                let end = String(token.suffix(7))
                let tokenD = ["token": start + "..." + end]
                print("请求头 : \(tokenD)")
            }
            print("headers : \(target.headers?.jsonString() ?? "")")
            if let request = result.rawReponse?.request {
                switch target.task {
                case .requestPlain, .uploadMultipart: break
                case let .requestParameters(parameters, _), let .uploadCompositeMultipart(_, parameters):
                    print("请求参数 : ", parameters)
                default:
                    if let requestBody = request.httpBody {
                        let decrypt = requestBody.parameterString()
                        print("请求参数 : \(decrypt)")
                    }
                }
            }

            switch result {
            case let .success(response):
                if let data = String(data: response.data, encoding: .utf8) {
                    print("""
                    http_Code : \(result.HttpCode)
                    message_Code :\(result.messageCode)
                    message : \(result.message)
                    """)
                    print("data：\r \(data))")
                } else {
                    let message = (try? response.map(String.self, atKeyPath: "error_description")) ?? ""
                    print("message: \(message)")
                }

            case let .failure(error):

                print("请求错误：\(error)")
            }

            // 删除完成的请求开始时间
//            NetworkingLogger.startDates.removeValue(forKey: String(describing: target))
            print("🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺\(target.path)🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺")
        #endif
    }
}


