//
//  ConversationList.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ConversationList: View {
    @EnvironmentObject var vm: ChatViewModel
    @FetchRequest(entity: ChatConversation.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \ChatConversation.createat, ascending: false),
    ])
    var chatConversations: FetchedResults<ChatConversation>

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(chatConversations, id: \.createat) { chatConversation in
                        let selecte = vm.currentConversation?.id == chatConversation.id
                        ConversationRow(chatConversation: chatConversation, selected: selecte)
                            .onTapGesture {
                                vm.currentConversation = chatConversation
                            }
                    }
                }
                .padding(.horizontal, 12)
            }
            HStack {
                ICON(name: "settinggear") {
                    Present(SettingView(), style: .pageSheet)
                }
                Spacer()
            }
            .padding(.all)
        }
    }
}

struct ConversationList_Previews: PreviewProvider {
    static var previews: some View {
        ConversationList()
            .environmentObject(ChatViewModel())
    }
}
