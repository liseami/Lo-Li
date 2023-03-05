//
//  PFNavigaionSheet.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/8.
//

import SwiftUI
import Introspect


/// 拥有独立Route的Navigation
struct PFNavigationView<Content>: View where Content: View {
    let content: (RouteStore) -> Content

    @State var route: RouteStore = .init()
    init(content: @escaping (RouteStore) -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationView {
            content(route)
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .introspectNavigationController { UINavigationController in
            route.register(UINavigationController)
        }
    }
}

struct PFNavigationSubView<Content>: View where Content: View {
    let content: (RouteStore) -> Content

    var route: RouteStore
    init(route: RouteStore, content: @escaping (RouteStore) -> Content) {
        self.route = route
        self.content = content
    }

    var body: some View {
        content(route)
    }
}
