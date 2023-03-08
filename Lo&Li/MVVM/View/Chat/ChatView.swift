//
//  ChatView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var vm: ChatViewModel

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
                            Text(message.content)
                                .ndFont(.body1b, color: .b2)
                                .padding(.all)
                                .frame(minWidth: 40, alignment: .trailing)
                                .addBack(cornerRadius: 10, backGroundColor: .teal, strokeLineWidth: 0, strokeFColor: .clear)
                                .NaduoShadow(color: .f2, style: .s300)
                                .NaduoShadow(color: .f3, style: .s100)
                                .frame(maxWidth: w * 0.618, alignment: .trailing)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal)
                                .padding(.horizontal, 12)
                                .scaleEffect(x: 1, y: -1, anchor: .center)

                        case .assistant:
                            HStack(alignment: .top, spacing: 12) {
                                Image("openapiavatar")
                                    .resizable()
                                    .frame(width: 44, height: 44, alignment: .center)
                                    .addBack(cornerRadius: 12, backGroundColor: .b1, strokeLineWidth: 1, strokeFColor: .b2)
                                    .padding(.top, 12)
                                VStack(alignment: .leading, spacing: 12) {
                                    TextField("", text: .constant(message.content), axis: .vertical)
                                        .ndFont(.body1, color: .f1)
                                    Text("\(message.tokens) Tokens")
                                        .font(.system(size: 14, weight: .thin, design: .monospaced))
                                        .foregroundColor(.teal)
                                }
                                .lineSpacing(2)
                                .addLoliCardBack()
                            }
                            .frame(maxWidth: w * 0.618, alignment: .leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.horizontal, 12)
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                        }
                    }
                    .contextMenu {
                        PF_MenuBtn(text: "删除", name: "trash", color: .red) {
                            PersistenceController.shared.container.viewContext.delete(messageEntity)
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
                        .fill(Color.teal.opacity(0.8).gradient)
                }
                .onSubmit {
                    vm.sendMessage()
                }
            Button {
                vm.sendMessage()
            } label: {
                ICON(name: "send",fcolor: .f1)
                    .frame(width: 44, height: 44, alignment: .center)
                    .addBack(cornerRadius: 10, backGroundColor: .b2, strokeLineWidth: 0, strokeFColor: .clear)
                    .NaduoShadow(color: .f2, style: .s300)
                    .NaduoShadow(color: .f3, style: .s100)
                    .padding(.all, 3)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(lineWidth: 1.5)
                            .fill(Color.f2.opacity(0.3).gradient)
                        //                        .shadow(color: .f1, radius: 1, x: 0, y: 0)
                    }
                    .padding(.all, 3)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(lineWidth: 4)
                            .fill(Color.f3.opacity(0.3).gradient)
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
                .fill(Color.teal.opacity(0.1).gradient)
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
