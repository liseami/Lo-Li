//
//  UserRedPacketAPI.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/12/7.
//

import Foundation

enum OpenAPI: FantasyTargetType {
    //  个人信息
    case models
    case chat(p: ChatReqMod)

    var group: String {
        "/v1"
    }

    var path: String {
        switch self {
        case .models: return "models"
        case .chat: return "chat/completions"
        }
    }

    var method: HTTPRequestMethod {
        switch self {
        case .models: return .get
        default: return .post
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .models: return nil
        case .chat(let p): return p.kj.JSONObject()
        }
    }
}

extension OpenAPI {
    struct ChatReqMod: Convertible {
        var model: String = "" // gpt-3.5-turbo",
        var messages: [ChatMessageModel] = []
    }
}


