//
//  RouteStore.swift
//  FantasyWindow
//
//  Created by Ze Liang on 2022/3/27.
//

import SwiftUI
import UIKit

class RouteStore: NSObject {
    static var shared = RouteStore()
    private(set) var navigationController: UINavigationController?
    // 注册全局母UIKitNavigationController...
    func register(_ nav: UINavigationController) {
        guard String(describing: type(of: nav)) == "UIKitNavigationController", navigationController == nil else { return }
        nav.delegate = self
        nav.interactivePopGestureRecognizer?.delegate = self
        navigationController = nav
        let appearance = UINavigationBarAppearance()
        guard let navibackbtn = UIImage(named: "navibackbtn") else { return }
        appearance.setBackIndicatorImage( navibackbtn.withRenderingMode(.alwaysOriginal), transitionMaskImage: navibackbtn)
        navigationController?.navigationBar.standardAppearance = appearance
    }

    func reset() {
        navigationController = nil
    }
}

//
extension RouteStore: UINavigationControllerDelegate {
    /*
     即将显示下一个视图...
     添加全屏回退手势
     如果在根视图，则删除这个手势...
     */
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.fixInteractivePopGestureRecognizer(delegate: self)
    }
}

extension RouteStore: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        otherGestureRecognizer is PanDirectionGestureRecognizer
    }
}

extension RouteStore {
    /// Push动作
    func push(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: true)
    }

    func push<Content: View>(_ content: Content, animated: Bool = false, navigationBarColor: Color = .white, needCoreDataEnvironment: Bool = false) {
        let BaseHostingViewController = FantasySwiftUIViewBox(content: content, needCoreDataEnvironment: needCoreDataEnvironment)
        push(BaseHostingViewController,
             animated: animated)
    }

    /// 返回
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    /// 返回到最顶层
    func popToRoot(animated: Bool = false) {
        _ = navigationController?.popToRootViewController(animated: animated)
        // 关闭所有sheet
        navigationController?.presentedViewController?.dismiss(animated: animated)
        // 调整导航栏颜色到b1
        guard navigationController != nil else { return }
//        changeNavigationBarApp(UINavigationController: navigationController!, changeTo: MakeNaviBarAppearance(color: .b1))
    }

    /// Present
    func present<Content: View>(
        _ content: Content,
        animated: Bool = true,
        style: UIModalPresentationStyle = .formSheet,
        needCoreDataEnvironment: Bool = false,
        isCloud: Bool = false
    ) {
        let HostController = isCloud ?
            CloudViewBox(content: content.background(ClearFullScreenBackView()), needCoreDataEnvironment: needCoreDataEnvironment)
            : FantasySwiftUIViewBox(content: content.background(ClearFullScreenBackView()), needCoreDataEnvironment: needCoreDataEnvironment)

        HostController.modalPresentationStyle = style
//        HostController.sheetPresentationController?.detents = detents
        HostController.modalTransitionStyle = .coverVertical
        HostController.isModalInPresentation = false
        if isCloud {
            present(HostController, animated: animated, style: .overFullScreen)
        } else {
            present(HostController, animated: animated, style: style)
        }
    }

    func present(_ vc: UIViewController, animated: Bool = false, style: UIModalPresentationStyle = .formSheet) {
        if #available(iOS 15.0, *) {
//            vc.sheetPresentationController?.detents = detents
            vc.sheetPresentationController?.selectedDetentIdentifier = .medium
            vc.sheetPresentationController?.preferredCornerRadius = 32
        } else {
            // Fallback on earlier versions
        }

        AppHelper().getCurrentViewController()?.present(vc, animated: animated)
//        _ = navigationController?.present(vc, animated: animated)
    }

    func closeSheet() {
        navigationController?.presentedViewController?.dismiss(animated: true)
    }

    // 发送警报
    func presentAlert(withTitle title: String, message: String, actions: [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let action = UIAlertAction(title: action.key, style: action.value) { action in
                if completionHandler != nil {
                    completionHandler!(action)
                }
            }
            alertController.addAction(action)
        }

        navigationController?.present(alertController, animated: true, completion: nil)
    }

    // 发送抽屉选项卡
    func presentActionSheet(withTitle title: String, message: String, actions: [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            let action = UIAlertAction(title: action.key, style: action.value) { action in
                if completionHandler != nil {
                    completionHandler!(action)
                }
            }
            alertController.addAction(action)
        }

        navigationController?.present(alertController, animated: true, completion: nil)
    }
}

/*
 页面导航公共方法...
 */

public func PushTo<Content: View>(_ content: Content, animated: Bool = true, navigationBarColor: Color = .white, needCoreDataEnvironment: Bool = false) {
    DispatchQueue.main.async {
        RouteStore.shared.push(content, animated: animated, navigationBarColor: navigationBarColor, needCoreDataEnvironment: needCoreDataEnvironment)
    }
}

public func Present<Content: View>(
    _ content: Content,
    animated: Bool = true,
    style: UIModalPresentationStyle = .formSheet,
    clearBack: Bool = true,
    needCoreDataEnvironment: Bool = false,
    isCloud: Bool = false
) {
    DispatchQueue.main.async {
        RouteStore.shared.present(content, animated: animated, style: style, needCoreDataEnvironment: needCoreDataEnvironment, isCloud: isCloud)
    }
}

public func PageBack() {
    DispatchQueue.main.async {
        RouteStore.shared.pop()
    }
}

public func BackToTop(animated: Bool = true) {
    DispatchQueue.main.async {
        RouteStore.shared.popToRoot(animated: animated)
    }
}

public func CloseSheet() {
    DispatchQueue.main.async {
        RouteStore.shared.closeSheet()
        mada(.impact(.rigid))
    }
}

public func silkyExitApp(from: Any) {
    UIApplication.shared.sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, from: from, for: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
        Darwin.exit(1)
    }
}

public func PresentAlert(withTitle title: String, message: String, actions: [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {
    DispatchQueue.main.async {
        RouteStore.shared.presentAlert(withTitle: title, message: message, actions: actions, completionHandler: completionHandler)
    }
}
