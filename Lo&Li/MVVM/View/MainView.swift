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
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(0 ..< 5) { _ in
                                ConversationRow(selected: Bool.random())
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
