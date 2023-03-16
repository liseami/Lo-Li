//
//  Networking.swift
//  Elena
//
//  Created by ash on 2019/10/15.
//  Copyright © 2019 荣恒. All rights reserved.
//

@_exported import Alamofire
import Combine
import Foundation
@_exported import KakaJSON
import Moya
@_exported import SwiftyJSON

open class CGI<Target: TargetType>: MoyaProvider<Target> {
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default,
                plugins: [PluginType] = [NetworkingLogger(), WarningPlugin(), TokenPlugin()])
    {
        configuration.timeoutIntervalForRequest = 30

        let session = Session(configuration: configuration)
        super.init(session: session, plugins: plugins)
    }
}

/*
 use: Networking.defaultProvider.request
 */
public enum Networking {
    public static var defaultProvider = CGI<MultiTarget>()
}

// MARK: - Combine普通请求

public extension Networking {
    @discardableResult
    static func publisher(_ target: TargetType) -> AnyPublisher<Response, MoyaError> {
        defaultProvider.requestPublisher(.init(target))
    }
}

// MARK: - 普通请求

public extension Networking {
    @discardableResult
    static func request(_ target: TargetType, completion: @escaping Completion) -> Moya.Cancellable {
        defaultProvider.requestWithNoObject(.init(target), completion: completion)
    }

    @discardableResult
    static func requestObject<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String? = "data", completion: @escaping (MoyaResult, T?) -> Void) -> Moya.Cancellable {
        defaultProvider.requestObject(.init(target), modeType: modeType, atKeyPath: keyPath, completion: completion)
    }

    @discardableResult
    static func requestArray<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String? = "data", completion: @escaping (MoyaResult, [T]?) -> Void) -> Moya.Cancellable {
        defaultProvider.requestArray(.init(target), modeType: modeType, atKeyPath: keyPath, completion: completion)
    }
}


public extension Networking {
    static func request_async(_ target: TargetType) async -> MoyaResult {
        await withCheckedContinuation { configuration in
            request(target) { result in
                configuration.resume(returning: result)
            }
        }
    }

    static func requestObject_async<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String? = "data") async -> (MoyaResult, T?) {
        return await withCheckedContinuation { configuration in
            requestObject(target, modeType: modeType, atKeyPath: keyPath) { r, t in
                configuration.resume(returning: (r, t))
            }
        }
    }

    static func requestArray_async<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String? = "data") async -> (MoyaResult, [T]?) {
        return await withCheckedContinuation { configuration in
            requestArray(target, modeType: modeType, atKeyPath: keyPath) { r, list in
                configuration.resume(returning: (r, list))
            }
        }
    }
}
