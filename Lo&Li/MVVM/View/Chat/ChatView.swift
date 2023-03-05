//
//  ChatView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var vm: ChatViewModel
    var body: some View {
        GeometryReader(content: { GeometryProxy in
            let w = GeometryProxy.size.width
            ScrollView(.vertical, showsIndicators: true) {
                Spacer().frame(height: 150, alignment: .center)
                ProgressView().frame(height: 32, alignment: .center)
                    .ifshow(vm.isLoading)
                ForEach(vm.messageList, id: \.createat) { message in
                    switch message.role {
                    case .user:
                        Text(message.content)
                            .ndFont(.body1b, color: .b1)
                            .padding(.all)
                            .frame(minWidth: 40, alignment: .trailing)
                            .addBack(cornerRadius: 10, backGroundColor: .teal, strokeLineWidth: 0, strokeFColor: .clear)
                            .NaduoShadow(color: .f2, style: .s300)
                            .NaduoShadow(color: .f3, style: .s100)
                            .padding(.all, 12)
                            .frame(maxWidth: w * 0.618, alignment: .trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
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
                                Text("\(message.tokens) Tokens")
                                    .font(.system(size: 14, weight: .thin, design: .monospaced))
                                    .foregroundColor(.teal)
                            }
                            .lineSpacing(2)
                            .addLoliCardBack()
                        }
                        .padding(.all, 12)
                        .frame(maxWidth: w * 0.618, alignment: .leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                    }
                }
            }
        })
        .onAppear(perform: {
            vm.userInput = "你好，从来就没有什么救世主。"
            delayWork(0.1) {
                vm.sendMessage()
            }
        })
        .frame(maxWidth: .infinity)
        .scaleEffect(x: 1, y: -1, anchor: .center)
        .overlay(alignment: .bottom) {
            inputView
                .padding(.all)
        }
    }

    var inputView: some View {
        HStack(spacing: 8) {
            TextField("输入内容...", text: $vm.userInput)
                .frame(height: 44, alignment: .center)
                .padding(.horizontal)
                .addBack(cornerRadius: 12, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
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
                ICON(name: "send")
                    .frame(width: 44, height: 44, alignment: .center)
                    .addBack(cornerRadius: 10, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
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
        .addBack(cornerRadius: 24, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
        .NaduoShadow(color: .f2, style: .s300)
        .NaduoShadow(color: .f3, style: .s100)
        .padding(.all, 6)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(lineWidth: 1)
                .fill(Color.teal.opacity(0.1).gradient)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ChatViewModel())
    }
}
