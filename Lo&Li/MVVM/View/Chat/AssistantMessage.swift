//
//  AssistantMessage.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/9.
//

import MarkdownView
import SwiftUI

struct AssistantMessage: View {
    let message: MessageToShow
    let w: CGFloat

    var messsageStr: String {
        message.content
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("openapiavatar")
                .resizable()
                .frame(width: 44, height: 44, alignment: .center)
                .addBack(cornerRadius: 12, backGroundColor: .b1, strokeLineWidth: 1, strokeFColor: .b2)
                .padding(.top, 12)
            VStack(alignment: .leading, spacing: 12) {
                MarkdownUI(body: messsageStr)
                Text("消耗：\(message.tokens) Tokens")
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
    }
}

struct AssistantMessage_Previews: PreviewProvider {
    static var previews: some View {
        AssistantMessage(message: .init(id: "djaj", content: """
        好的，以下是一个简单的SwiftUI代码示例，它创建了一个文本视图和一个按钮：

        import SwiftUI

        struct ContentView: View {
            var body: some View {
                VStack {
                    Text("Hello, world!")
                        .font(.largeTitle)
                        .padding()

                    Button(action: {
                        print("Button was tapped")
                    }) {
                        Text("Tap me!")
                            .font(.headline)
                    }
                }
            }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
        这个代码创建了一个包含一个文本视图和一个按钮的垂直堆栈。文本视图设置了“Hello, world！”的文本和大标题字体，并使用填充向其添加了一些空白。按钮被设置为在按下时将一条消息打印到控制台。

        希望这个示例能帮助到你快速入门SwiftUI！
        """, role: "a", createat: "", tokens: "2323"),
        w: 240)
    }
}
