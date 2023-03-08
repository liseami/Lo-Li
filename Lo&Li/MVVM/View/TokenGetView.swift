//
//  TokenGetView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct TokenGetView: View {
    @State private var tokenInput: String
    init() {
        _tokenInput = State(wrappedValue: UserManager.shared.AccessToken)
    }

    var body: some View {
        ZStack {
            Color.b1.ignoresSafeArea()
            GeometryReader { GeometryProxy in
                let w = GeometryProxy.size.width
                VStack(spacing: 32) {
                    Text("Lo&Li需要你的Token才能运行")
                        .ndFont(.t1b)
                    Text("去 [https://platform.openai.com/account/api-keys](https://platform.openai.com/account/api-keys) 创建并复制你的Token")
                        .ndFont(.body1)

                    if w > 500 {
                        Group {
                            inputView
                            startBtn
                        }
                        .frame(width: 777, alignment: .center)
                    } else {
                        Group {
                            inputView
                            startBtn
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.all)
                .frame(maxHeight: .infinity, alignment: .center)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    var startBtn: some View {
        LoliBtn(type: .large, config: .init(title: "开始聊天", leftIcon: "send", btnColor: .b1, contentColor: .f1), status: .defult) {
            DispatchQueue.main.async {
                UserManager.shared.AccessToken = tokenInput
            }
        }
    }

    var inputView: some View {
        HStack(spacing: 8) {
            TextField("粘贴你的Token...", text: $tokenInput)
                .font(.system(size: 24, weight: .thin, design: .rounded))

                .multilineTextAlignment(.center)
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
                    UserManager.shared.AccessToken = tokenInput
                }
        }
        .addLoliCardBack()
    }
}

struct TokenGetView_Previews: PreviewProvider {
    static var previews: some View {
        TokenGetView()
    }
}
