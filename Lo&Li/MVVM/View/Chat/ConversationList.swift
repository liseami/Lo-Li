//
//  ConversationList.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ConversationList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var vm: ChatViewModel
    @FetchRequest(entity: ChatConversation.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \ChatConversation.createat, ascending: false),
    ])
    var chatConversations: FetchedResults<ChatConversation>

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(chatConversations, id: \.createat) { chatConversation in
                    let selecte = vm.currentConversation?.id == chatConversation.id

                    NavigationLink(tag: chatConversation, selection: $vm.currentConversation) {
                        ChatView()
                            .environmentObject(vm)
                    } label: {
                        ConversationRow(chatConversation: chatConversation, selected: selecte)
                            .onTapGesture {
                                vm.currentConversation = chatConversation
                            }
                            .contextMenu {
                                PF_MenuBtn(text: "删除", sysname: "trash", color: .red) {
                                    // 删除
                                    self.vm.currentConversation = nil
                                    viewContext.delete(chatConversation)
                                    coreDataSave {} onError: {}
                                }
                            }
                    }

//                    NavigationLink {
//                        ChatView()
//                            .environmentObject(vm)
////                        Color.red
//                    } label: {
//                        ConversationRow(chatConversation: chatConversation, selected: selecte)
//                            .onTapGesture {
//                                vm.currentConversation = chatConversation
//                            }
//                            .contextMenu {
//                                PF_MenuBtn(text: "删除", sysname: "trash", color: .red) {
//                                    // 删除
//                                    self.vm.currentConversation = nil
//                                    viewContext.delete(chatConversation)
//                                    coreDataSave {} onError: {}
//                                }
//                            }
//                    }
//

                    //                            .navigationBarTitleDisplayMode(.inline)
                    //                            .environmentObject(vm)
                }
            }
            .padding(.horizontal, 12)
        }
    }
}

struct ConversationList_Previews: PreviewProvider {
    static var previews: some View {
        ConversationList()
            .environmentObject(ChatViewModel())
    }
}
