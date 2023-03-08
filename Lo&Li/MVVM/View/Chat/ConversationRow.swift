//
//  ConversationRow.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ConversationRow: View {
    let chatConversation: ChatConversation
    var selected: Bool

    @State private var onHover: Bool = false
    @State private var newNameInput: String
    init(chatConversation: ChatConversation, selected: Bool = false) {
        self.chatConversation = chatConversation
        self.selected = selected
        _newNameInput = State(wrappedValue: chatConversation.title)
    }

    var body: some View {
        HStack {
            if onHover {
                TextField("", text: $newNameInput)
                    .ndFont(.body1, color: .f1)
                    .onSubmit {
                        chatConversation.title = self.newNameInput
                        coreDataSave {
                            AppHelper().popTosta(type: .ok(p: .init(title: "修改成功", subline: "对话名称已修改成功。")))
                        } onError: {}
                    }
            } else {
                Text(chatConversation.title)
                    .ndFont(.body1, color: .f1)
            }
            Spacer()
        }
        .padding(.all, 12)
        .addBack(cornerRadius: 10, backGroundColor: onHover ? .teal.opacity(0.1) : .b2, strokeLineWidth: 0, strokeFColor: .clear)
        .NaduoShadow(color: .f2, style: .s300)
        .NaduoShadow(color: .f3, style: .s100)
        .padding(.all, 3)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: selected ? 3 : 1.5)
                .fill(selected ? Color.teal.opacity(0.3).gradient : Color.f2.opacity(0.3).gradient)
        }
        .padding(.all, 3)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(lineWidth: 4)
                .fill(selected ? Color.teal.opacity(0.1).gradient : Color.f3.opacity(0.3).gradient)
        }
        .onHover { onHover in
            self.onHover = onHover
            if !onHover {
                self.newNameInput = chatConversation.title
            }
        }
    }
}

struct ConversationRow_Previews: PreviewProvider {
    static var previews: some View {
        let chatConversation = ChatConversation(context: PersistenceController.shared.container.viewContext)
        chatConversation.title = "morenbiaoti"
        return VStack {
            ConversationRow(chatConversation: chatConversation)
            ConversationRow(chatConversation: chatConversation, selected: true)
        }
        .padding(.horizontal, 100)
    }
}
