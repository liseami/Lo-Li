//
//  NaduoDesginSystemView.swift
//  Naduo
//
//  Created by 赵翔宇 on 2023/2/17.
//

import SwiftUI

struct NaduoDesginSystemView: View {
    var body: some View {
        List {
            Button("文字") {
                PushTo(texts)
            }
            Button("颜色") {
                PushTo(colors)
            }
            Button("按钮") {
                PushTo(btns)
            }
            Button("Section") {
                PushTo(sections)
            }
        }
    }

    var sections: some View {
        VStack {
            
        }
        .naduoPadding()
    }

    @ViewBuilder
    var texts: some View {
        HStack {
            VStack {
                Text("那朵文字系统 t1")
                    .ndFont(.t1)
                Text("那朵文字系统 t1b")
                    .ndFont(.t1b)
                Text("那朵文字系统 t2")
                    .ndFont(.t2)
                Text("那朵文字系统 t2b")
                    .ndFont(.t2b)
                Text("那朵文字系统 b1")
                    .ndFont(.body1)
                Text("那朵文字系统 b1b")
                    .ndFont(.body1b)
                Text("那朵文字系统 b2")
                    .ndFont(.body2)
                Text("那朵文字系统 b2b")
                    .ndFont(.body2b)
                Text("那朵文字系统 b3")
                    .ndFont(.body3)
                Text("那朵文字系统 b3b")
                    .ndFont(.body3b)
            }
            VStack {
                Text("那朵文字系统 c1")
                    .ndFont(.c1)
                Text("那朵文字系统 c1b")
                    .ndFont(.c1b)
                Text("那朵文字系统 c2")
                    .ndFont(.c2)
                Text("那朵文字系统 c2b")
                    .ndFont(.c2b)
            }
        }
    }

    @ViewBuilder
    var colors: some View {
        let color = VStack {
            Color.acc1
            Color.acc2
            Color.f1
            Color.f2
            Color.f3
            Color.b1
            Color.b2
            Color.b3
            Color.b4
        }

        HStack {
            color
                .environment(\.colorScheme, .light)
            color
                .environment(\.colorScheme, .dark)
        }
        .naduoPadding()
    }

    var btns: some View {
        VStack {
            LoliBtn(type: .large, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .b1)) {
                await waitme()
            }
            LoliBtn(type: .large, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .b1), status: .disabled(reason: "不可点击", action: {})) {
                await waitme()
            }
            
            LoliBtn(type: .large, config: .init(title: "创建账号", btnColor: .black, contentColor: .b1)) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .b1)) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .b1), status: .disabled(reason: "不可点击", action: {})) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "创建账号", btnColor: .black, contentColor: .b1)) {
                await waitme()
            }
        }
        .padding(.horizontal, .Naduo.padding18)
    }
}

struct NaduoDesginSystemView_Previews: PreviewProvider {
    static var previews: some View {
        NaduoDesginSystemView()
        NaduoDesginSystemView().btns
        NaduoDesginSystemView().colors
        NaduoDesginSystemView().texts
        NaduoDesginSystemView().sections
    }
}
