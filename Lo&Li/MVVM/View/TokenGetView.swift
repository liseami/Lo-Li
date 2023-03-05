//
//  TokenGetView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct TokenGetView: View {
    var body: some View {
        VStack(spacing: 32) {
            Text("Lo&Li需要你的Token才能运行")
                .ndFont(.t1b)
            Text("去 [https://platform.openai.com/account/api-keys](https://platform.openai.com/account/api-keys) 创建并复制你的Token")
                .ndFont(.body1)
            inputView
                .frame(width: 320)

            LoliBtn(type: .large, config: .init(title: "开始聊天", leftIcon: "send", btnColor: .b1, contentColor: .f1), status: .defult) {
                UserManager.shared.AccessToken = "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"
            }
            .frame(width: 200, alignment: .center)
            .padding(.top, 120)
        }
        .padding(.all)
    }

    var inputView: some View {
        HStack(spacing: 8) {
            TextField("粘贴你的Token...", text: .constant(""))
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
        }
        .addLoliCardBack()
    }
}

struct TokenGetView_Previews: PreviewProvider {
    static var previews: some View {
        TokenGetView()
    }
}
