//
//  ChatView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct MainView: View {
    @StateObject var uistate: UIState = .init()
    @StateObject var chatViewModel: ChatViewModel = .init()
    var body: some View {
        ZStack {
            NavigationSplitView(columnVisibility: $uistate.columnVisibility) {
                ConversationList()
                    .environmentObject(chatViewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ICON(name: "plus")
                    }
                }

            } detail: {
                ChatView()
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(chatViewModel)
            }
            .navigationSplitViewStyle(.automatic)
            .introspectNavigationController(customize: { navigationController in
                // RouterStore注册...
                RouteStore.shared.register(navigationController)
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
