//
//  ChatViewModel.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var currentModel: String = "gpt-3.5-turbo"
    @Published var userInput: String = ""

    @Published var isLoading: Bool = false

    func sendMessage() {
        self.isLoading = true
        let viewContext = PersistenceController.shared.container.viewContext
        // 向本地数据库添加一条用户发送的信息
        ChatMessage(context: viewContext).addNew(mod: MessageToShow(id: "", content: self.userInput, role: MessageToShow.Role.user.rawValue, createat: Date.now.timestamp.string, tokens: ""))
//        self.messageList.insert(MessageToShow(content: self.userInput, role: .user, createat: Date.now.timestamp.string), at: 0)
        self.userInput.removeAll()
        // 总结历史信息
        let chatHistory = ChatMessageDataManager.shared.messages.reversed().map { ChatMessage in
            ChatMessageModel(role: ChatMessage.wrapvalue.role, content: ChatMessage.wrapvalue.content)
        }
        // 用会话中的历史信息一起请求新的回答
        let target = OpenAPI.chat(p: .init(model: self.currentModel, messages: chatHistory))
        Networking.requestObject(target, modeType: ChatResponse.self, atKeyPath: nil) { r, obj in
            if r.isSuccess, let obj {
                obj.choices.forEach { ChatResponseChoice in
                    // 将新的回答插入数据库
                    ChatMessage(context: viewContext).addNew(mod: MessageToShow(content: ChatResponseChoice.message.content, role: MessageToShow.Role.assistant.rawValue, createat: obj.created, tokens: obj.usage.total_tokens))
                }
            }
            self.isLoading = false
        }
    }
}
