//
//  Message.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct MessageToShow: Convertible {
    enum Role: String, CaseIterable {
        case user
        case assistant
    }

    var id: String = ""
    var content: String = ""
    var roletype: Role {
        Role.allCases.first { Role in
            Role.rawValue == role
        } ?? .user
    }

    var role: String = ""

    var createat: String = ""
    var tokens: String = ""
}

struct ChatResponse: Convertible {
    var id: String = "" // chatcmpl-123",
    var object: String = "" // chat.completion",
    var created: String = "" // 1677652288,
    var choices: [ChatResponseChoice] = []
    var usage: ChatUsage = .init()
}

struct ChatResponseChoice: Convertible {
    var index: Int = 0
    var message: ChatMessageModel = .init()
    var finish_reason: String = "" // stop"
}

struct ChatUsage: Convertible {
    var prompt_tokens: String = "" // 9,
    var completion_tokens: String = "" // 12,
    var total_tokens: String = "" // 21
}

struct ChatMessageModel: Convertible {
    var roleType: MessageToShow.Role {
        return role == "user" ? .user : .assistant
    }

    var role: String = ""
    var content: String = ""
}
