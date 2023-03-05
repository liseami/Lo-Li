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
    @Published var messageList: [MessageToShow] = []
    @Published var isLoading: Bool = false

    func sendMessage() {
        self.isLoading = true
        withAnimation(.NaduoSpring) {
            self.isLoading = false
            guard let response = MockTool.readObject(ChatResponse.self, fileName: "citys", atKeyPath: nil) else { return }
            self.messageList.insert(contentsOf: response.choices.map { ChatResponseChoice in
                MessageToShow(content: ChatResponseChoice.message.content, role: ChatResponseChoice.message.roleType, createat: response.created, tokens: response.usage.total_tokens)
            }, at: 0)
        }
//        self.messageList.insert(MessageToShow(content: self.userInput, role: .user, createat: Date.now.timestamp.string), at: 0)
//        self.userInput.removeAll()
//        let chatHistory = self.messageList.reversed().map { MessageToShow in
//            ChatMessage(role: MessageToShow.role.rawValue, content: MessageToShow.content)
//        }
//        let target = OpenAPI.chat(p: .init(model: self.currentModel, messages: chatHistory))
//        Networking.requestObject(target, modeType: ChatResponse.self, atKeyPath: nil) { r, obj in
//            if r.isSuccess, let obj {
//                withAnimation(.NaduoSpring) {
//                    self.messageList.insert(contentsOf: obj.choices.map { ChatResponseChoice in
//                        MessageToShow(content: ChatResponseChoice.message.content, role: ChatResponseChoice.message.roleType, createat: obj.created, tokens: obj.usage.total_tokens)
//                    }, at: 0)
//                }
//            }
//            self.isLoading = false
//        }
    }
}

