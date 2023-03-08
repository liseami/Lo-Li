//
//  Tosta.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/17.
//

import SwiftUI

func LoadingTask(ViewController: UIViewController? = AppHelper().getCurrentViewController(), loadingMessage: String, task: @escaping () async -> ()) {
    Task {
        let message = loadingMessage
        let alert = await UIAlertController(title: nil, message: message, preferredStyle: .alert)

        DispatchQueue.main.async {
            ViewController?.present(alert, animated: true)
        }

        await task()

        DispatchQueue.main.async {
            alert.dismiss(animated: false)
        }
    }
}

struct Tosta: View {
    let title: String
    let subline: String?
    let animationJson: String

    init(title: String, subline: String?, animationJson: String) {
        self.title = title
        self.subline = subline
        self.animationJson = animationJson
    }

    @ObservedObject var uistate: UIState = .shared
    @Environment(\.colorScheme) private var systemColorSheme
    var body: some View {
        BlurView()
            .frame(width: w, height: w, alignment: .center)
            .addBack(cornerRadius: 24, backGroundColor: .clear, strokeLineWidth: 1, strokeFColor: .b2)
            .overlay {
                VStack {
                    AutoLottieView(lottieFliesName: animationJson, loopMode: .loop)
                        .frame(width: w * 0.5, height: w * 0.5)
                    VStack(spacing: 4) {
                        Text(title)
                            .ndFont(.body2b,color: .f2)

                        if let subline = subline {
                            Text(subline)
                                .ndFont(.body2b,color: .f2)
                        }
                    }
                }
                .padding(.all, 12)
            }
            .environment(\.colorScheme, uistate.ColorShemeModel == 0 ? systemColorSheme : uistate.ColorShemeModel == 1 ? .light : .dark)
        
    }

    var w: CGFloat {
        200
    }
}

struct Tosta_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.b1
            Tosta(title: "Tosta_Check_OK", subline: "subline，subline，subline，subline，subline", animationJson: "Title")
        }
    }
}

class TostaManager {
    static let shared: TostaManager = .init()

    var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window
        else {
            return nil
        }
        return window
    }

    /*
     组装
     */
    func make() {}

    /*
     发射
     */
    func send(tosta: Tosta) {
        let view = FantasySwiftUIViewBox(content: tosta).view
        if let window = window {
            window.addSubview(view!)
            view?.center = window.center
            view?.tag = 1
            // 默认2.7秒回收
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                view?.removeFromSuperview()
            }
        }
    }

    /// 发送预设Tosta
    /// - Parameter type: 预设的枚举
    func send(type: TostaPreset) {
        switch type {
        case .ok(let p): send(tosta: .init(title: p.title, subline: p.subline, animationJson: type.lottieFileName))
        case .collected(let p):
            send(tosta: .init(title: p.title, subline: p.subline, animationJson: type.lottieFileName))
        case .trash(let p):
            send(tosta: .init(title: p.title, subline: p.subline, animationJson: type.lottieFileName))
        case .user(let p):
            send(tosta: .init(title: p.title, subline: p.subline, animationJson: type.lottieFileName))
        }
    }

    /*
     回收
     */
    func kill() {}
}

extension TostaManager {
    struct TextInfo {
        var title: String
        var subline: String
    }

    // 预设
    public enum TostaPreset {
        case ok(p: TextInfo)
        case collected(p: TextInfo)
        case trash(p: TextInfo)
        case user(p: TextInfo)
        var lottieFileName: String {
            switch self {
            case .ok: return "Tosta_Check_OK"
            case .collected: return "Tosta_Check_OK"
            case .trash: return "Tosta_Check_Trash"
            case .user: return "Tosta_Check_User"
            }
        }
    }
}
