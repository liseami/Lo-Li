//
//  NetWorkingSetting.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/2/21.
//

import Foundation
import Moya

public typealias HTTPRequestMethod = Moya.Method

public protocol FantasyTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var group: String { get }
}


public extension FantasyTargetType {
    var baseURL: URL {
        URL(string: AppConfig.baseUrl)?.appendingPathComponent(group) ?? URL(string: "https://test.com")!
    }
    
    var path: String {
        let path = String(describing: self)
        return "/" + path.components(separatedBy: "(").first!
    }

    var group: String { "" }

    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch method {
        case .get:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        case .post, .put, .delete:
            return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)

        default:
            return .requestPlain
        }
    }

    var parameters: [String: Any]? { nil }

    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }

    // Token in Header...
    var headers: [String: String]? {
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "Bearer" + " " + UserManager.shared.AccessToken
        
//        if AppConfig.env == .test, UserManager.shared.accessToken.isEmpty {
//            headers["token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTIzMzQzODkifQ.cfC85ANvZD4AES2xV-TCged03E1SYncmaWSSa6wW6c8"
//        }

        return headers
    }
}
