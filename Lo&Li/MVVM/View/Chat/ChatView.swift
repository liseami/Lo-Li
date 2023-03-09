//
//  ChatView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//


import SwiftUI
import WebKit

struct ChatView: View {
    @EnvironmentObject var vm: ChatViewModel
    @Environment(\.managedObjectContext) private var viewContext
    var currentConversation: ChatConversation? {
        vm.currentConversation
    }

    var messages: [ChatMessage] {
        guard let currentConversation else { return [] }
        return Array(currentConversation.messages ?? []).sorted { $0.createat > $1.createat }
    }

    var body: some View {
        GeometryReader(content: { GeometryProxy in
            let w = GeometryProxy.size.width
            ScrollView(.vertical, showsIndicators: true) {
                Spacer().frame(height: 150, alignment: .center)
                AutoLottieView(lottieFliesName: "ailoading", loopMode: .loop, speed: 3)
                    .frame(height: 160, alignment: .center)
                    .transition(.scale.combined(with: .opacity).animation(.NaduoSpring))
                    .animation(.NaduoSpring, value: vm.isLoading)
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                    .ifshow(vm.isLoading)

                if messages.isEmpty {
                    Text("说点什么")
                        .ndFont(.body1, color: .f2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                }

                ForEach(messages, id: \.createat) { messageEntity in
                    let message = messageEntity.wrapvalue
                    Group {
                        switch message.roletype {
                        case .user:
                            TextField("", text: .constant(message.content))
                                .ndFont(.body1b, color: .b2)
                                .padding(.all)
                                .frame(minWidth: 40, alignment: .trailing)
                                .addBack(cornerRadius: 10, backGroundColor: .teal, strokeLineWidth: 0, strokeFColor: .clear)
                                .NaduoShadow(color: .f2, style: .s300)
                                .NaduoShadow(color: .f3, style: .s100)
                                .frame(maxWidth: w * 0.618 * 0.618, alignment: .trailing)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal)
                                .padding(.horizontal, 12)
                                .scaleEffect(x: 1, y: -1, anchor: .center)

                        case .assistant:
                            AssistantMessage(message: message, w: w)
                                .scaleEffect(x: 1, y: -1, anchor: .center)
                        }
                    }
                    .contextMenu {
                        PF_MenuBtn(text: "删除", name: "trash", color: .red) {
                            viewContext.delete(messageEntity)
                            coreDataSave {
                                vm.objectWillChange.send()
                            } onError: {}
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .scaleEffect(x: 1, y: -1, anchor: .center)
            .overlay(alignment: .bottom) {
                inputView
            }
        })
        .overlay(
            HStack(spacing: 16) {
                Spacer()
                ICON(sysname: "list.bullet.indent", fcolor: .f1, size: 24, fontWeight: .regular) {
//                    UIState.shared.columnVisibility = NavigationSplitViewVisibility.all
                }
                ICON(sysname: "arrow.clockwise", fcolor: .f1, size: 24, fontWeight: .regular) {
                    AppHelper().presentAlert(withTitle: "确定要清空对话？", message: "不可恢复。", actions: [.init(title: "确认", style: .destructive), .init(title: "点错了", style: .cancel)]) { UIAlertAction in
                        if UIAlertAction.title == "确认" {
                            vm.currentConversation?.messages?.forEach { message in
                                viewContext.delete(message)
                            }
                            coreDataSave {
                                vm.objectWillChange.send()
                            } onError: {}
                        }
                    }
                }
            }
            .addGoldenPadding()
            .addLoliBtnBack()
            .frame(maxWidth: 200)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.all),

            alignment: .top)
        .navigationBarHidden(true)
    }

    var inputView: some View {
        HStack(spacing: 8) {
            TextField("输入内容...", text: $vm.userInput)
                .ndFont(.body1, color: .f1)
                .frame(height: 44, alignment: .center)
                .padding(.horizontal)
                .addBack(cornerRadius: 12, backGroundColor: .b2, strokeLineWidth: 0, strokeFColor: .clear)
                .NaduoShadow(color: .f2, style: .s300)
                .NaduoShadow(color: .f3, style: .s100)
                .padding(.all, 4)
                .overlay(alignment: .center) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(lineWidth: 2)
                        .fill(Color.teal.opacity(0.8))
                }
                .onSubmit {
                    vm.sendMessage()
                }
            Button {
                vm.sendMessage()
            } label: {
                ICON(name: "send", fcolor: .f1)
                    .frame(width: 44, height: 44, alignment: .center)
                    .addBack(cornerRadius: 10, backGroundColor: .b2, strokeLineWidth: 0, strokeFColor: .clear)
                    .NaduoShadow(color: .f2, style: .s300)
                    .NaduoShadow(color: .f3, style: .s100)
                    .padding(.all, 3)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(lineWidth: 1.5)
                            .fill(Color.f2.opacity(0.3))
                        //                        .shadow(color: .f1, radius: 1, x: 0, y: 0)
                    }
                    .padding(.all, 3)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(lineWidth: 4)
                            .fill(Color.f3.opacity(0.3))
                        //                        .shadow(color: .f1, radius: 1, x: 0, y: 0)
                    }
            }
        }
        .padding(.all)
        .addBack(cornerRadius: 24, backGroundColor: .b2, strokeLineWidth: 0, strokeFColor: .clear)
        .NaduoShadow(color: .f2, style: .s300)
        .NaduoShadow(color: .f3, style: .s100)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(lineWidth: 1)
                .fill(Color.teal.opacity(0.1))
        }
        .padding(.all, 12)
        .padding(.horizontal, 12)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ChatViewModel())
    }
}

struct WebView: UIViewRepresentable {
    var html: String

    init(html: String) {
        self.html = html
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let css = """
        <style>
        body {
            background-color: #FBFAF9;
            color: black;
            font-size: 20px;
        }
        </style>
        """
        uiView.loadHTMLString(css + html, baseURL: nil)
    }
}
