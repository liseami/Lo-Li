//
//  FantasyUI.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/19.
//  Submodule of Cashmix App and TimeMachine App

import SwiftUI

#if canImport(AppKit)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

public extension SwiftUI.View {
    func GoBackground<SomeView>(_ view: SomeView) -> some View where SomeView: View {
        background(view)
    }
}

public extension SwiftUI.View {
    /// 封装系统Navilink
    func PF_Navilink<Link>(isPresented: Binding<Bool>, content: @escaping () -> Link) -> some View where Link: View {
        GoBackground(
            NavigationLink(isActive: isPresented) {
                content()
            } label: {
                EmptyView()
            }
        )
    }

    /// 封装系统Sheet
    /// 解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
    func PF_SystemSheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)?, backClear: Bool = false, content: @escaping () -> Content) -> some View where Content: View {
        GoBackground(Text("金诚所至，金石为开")
            .opacity(0)
            .sheet(isPresented: isPresented, onDismiss: onDismiss, content: {
                if backClear {
                    content()
                        .background(ClearFullScreenBackView())
                } else {
                    content()
                }

            }))
    }

    /// 封装系统FullScreen
    /// 解决iOS14.4出现的单一响应问题：一个View多个Sheet只有最后一个响应
    func PF_FullScreen<Content>(isPresented: Binding<Bool>, backClear: Bool = false, onDismiss: (() -> Void)?, content: @escaping () -> Content) -> some View where Content: View {
        GoBackground(Text("金诚所至，金石为开")
            .opacity(0)
            .fullScreenCover(isPresented: isPresented, onDismiss: onDismiss, content: {
                if backClear {
                    content()
                        .background(ClearFullScreenBackView())
                } else {
                    content()
                }
            }))
    }
}
