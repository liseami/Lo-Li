//
//  ChatView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var uistate: UIState = .shared
    @StateObject var chatViewModel: ChatViewModel = .init()
    var body: some View {
        NavigationView {
            VStack {
                ConversationList()
                    .environmentObject(chatViewModel)
                HStack {
                    NavigationLink {
                        SettingView()
                    } label: {
                        ICON(name: "settinggear", fcolor: .f1)
                    }

                    Spacer()
                }
                .padding(.all)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ICON(name: "plus", fcolor: .f1) {
                        let new = ChatConversation(context: PersistenceController.shared.container.viewContext)
                            .creatNew()
                        coreDataSave {
                            chatViewModel.currentConversation = new
                        } onError: {}
                    }
                }
            }
        }
        .navigationViewStyle(.columns)
        .introspectNavigationController(customize: { navigationController in
            // RouterStore注册...
            RouteStore.shared.register(navigationController)
        })

//        NavigationSplitView(columnVisibility: $uistate.columnVisibility) {
//
//
//        } detail: {
//            ChatView()
//                .navigationBarTitleDisplayMode(.inline)
//                .environmentObject(chatViewModel)
//        }
//        .navigationSplitViewStyle(.automatic)
//        .introspectNavigationController(customize: { navigationController in
//            // RouterStore注册...
//            RouteStore.shared.register(navigationController)
//        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
