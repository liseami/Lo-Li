//
//  NaduoButton.swift
//  Naduo
//
//  Created by 赵翔宇 on 2023/2/17.
//

import SwiftUI

struct LoliBtn: View {
    /*
     UI配置
     */
    struct NDBtnConfig {
        var title: String
        var leftIcon: String?
        var btnColor: Color = .black
        var contentColor: Color = .white
    }

    /*
     类型
     */
    enum NDBtnType {
        case large
        case small
    }

    /*
     状态
     */
    enum NDBtnStatus: Equatable {
        case defult
        case disabled(reason: String, action: () -> Void)
        static func == (lhs: NDBtnStatus, rhs: NDBtnStatus) -> Bool {
            switch (lhs, rhs) {
            case (.defult, .defult):
                return true
            case (.disabled(_, _), .disabled(_, _)):
                return true
            default:
                return false
            }
        }
    }

    @State private var isLoading: Bool = false

    // 类型
    var type: NDBtnType
    // UI设置
    var config: NDBtnConfig
    // 按钮状态
    var status: NDBtnStatus
    // 按钮正常行为
    let action: () async -> Void

    init(
        type: NDBtnType,
        config: NDBtnConfig,
        status: NDBtnStatus = .defult,
        action: @escaping () async -> Void
    ) {
        self.type = type
        self.config = config
        self.status = status
        self.action = action
    }

    var height: CGFloat {
        switch self.type {
        case .large: return 52
        case .small: return 36
        }
    }

    var iconsize: CGFloat {
        switch self.type {
        case .large: return 28
        case .small: return 20
        }
    }

    var body: some View {
        Button {
            tapBtn()
        } label: {
            label
                .frame(height: height, alignment: .center)
                .addLoliBtnBack()
        }
        .buttonStyle(NaduoMainButtonStyle())
        .opacity(self.status == .defult ? 1 : 0.9)
        .grayscale(self.status == .defult ? 0 : 0.7)
    }

    @ViewBuilder
    /*
     Large 大按钮无限宽
     Small 小按钮有限宽，横向padding 18
     */
    var label: some View {
        switch self.type {
        case .large:
            content
                .frame(maxWidth: .infinity)
        case .small:
            content
                .padding(.horizontal, .Naduo.padding18)
        }
    }

    @ViewBuilder
    /*
     ICON，文字
     */
    var content: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: config.contentColor))
        } else {
            HStack(spacing: .Naduo.padding12) {
                if let icon = config.leftIcon {
                    ICON(name: icon, fcolor: self.config.contentColor, size: iconsize, renderMode: .template)
                }
                switch self.type {
                case .large:
                    Text(self.config.title)
                        .ndFont(.body1b, color: self.config.contentColor)
                case .small:
                    Text(self.config.title)
                        .ndFont(.body3b, color: self.config.contentColor)
                }
            }
        }
    }

    // 点击按钮
    func tapBtn() {
        guard !self.isLoading else { return }
        switch self.status {
        // 正常点击
        case .defult:
            withAnimation(.NaduoSpring) {
                self.isLoading = true
            }
            Task {
                await action()
                DispatchQueue.main.async {
                    withAnimation(.NaduoSpring) {
                        self.isLoading = false
                    }
                }
            }
        // 禁用点击
        case let .disabled(reason: reason, action: action):
            pushPop(reason, style: .onlytext)
            action()
            mada(.error); return
        }
    }
}

struct NaduoMainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let label = configuration.label
            .scaleEffect(isPressed ? 0.96 : 1, anchor: .center)
            .opacity(isPressed ? 0.9 : 1)
            .NaduoShadow(color: isPressed ? .f1 : .clear, style: .s200)
        return label
    }
}

struct NaduoButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoliBtn(type: .large, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .f1)) {
                await waitme()
            }
            LoliBtn(type: .large, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .f1), status: .disabled(reason: "不可点击", action: {})) {
                await waitme()
            }
            LoliBtn(type: .large, config: .init(title: "创建账号", btnColor: .black, contentColor: .f1)) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .f1)) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "那朵按钮", btnColor: .MainColor, contentColor: .f1), status: .disabled(reason: "不可点击", action: {})) {
                await waitme()
            }
            LoliBtn(type: .small, config: .init(title: "创建账号", btnColor: .black, contentColor: .f1)) {
                await waitme()
            }
        }
        .padding(.horizontal, .Naduo.padding18)
    }
}
