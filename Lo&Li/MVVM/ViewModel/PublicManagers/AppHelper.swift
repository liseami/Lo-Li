//
//  AppHelper.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/30.
//

import MessageUI
import UserNotifications

class AppHelper {}

extension AppHelper {
    /// Push动作
    func push(_ vc: UIViewController, animated: Bool = true) {
        if let navi = getCurrentViewController() as? UINavigationController {
            navi.pushViewController(vc, animated: animated)
        }
    }

    func push<Content: View>(_ content: Content, animated: Bool = false, navigationBarColor: Color = .white) {
        let BaseHostingViewController = FantasySwiftUIViewBox(content: content)
        push(BaseHostingViewController,
             animated: animated)
    }
}

extension AppHelper {
    /*
     获取最顶层ViewController
     */
    func getTopViewController() -> UIViewController? {
        let connectedScenes = UIApplication.shared.connectedScenes
        for scene in connectedScenes {
            if let sceneDelegate = scene.delegate as? UIWindowSceneDelegate {
                if let window = sceneDelegate.window, let rootViewController = window?.rootViewController {
                    return rootViewController
                }
            }
        }
        return nil
    }

    /*
     获取当前呈现的ViewController
     */
    func getCurrentViewController() -> UIViewController? {
        let connectedScenes = UIApplication.shared.connectedScenes
        for scene in connectedScenes {
            if let sceneDelegate = scene.delegate as? UIWindowSceneDelegate {
                if let window = sceneDelegate.window, let rootViewController = window?.rootViewController {
                    var currentViewController: UIViewController? = rootViewController
                    while currentViewController?.presentedViewController != nil {
                        currentViewController = currentViewController?.presentedViewController
                    }
                    return currentViewController
                }
            }
        }
        return nil
    }

    func getWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
        for scene in connectedScenes {
            if let sceneDelegate = scene.delegate as? UIWindowSceneDelegate {
                if let window = sceneDelegate.window {
                    return window
                }
            }
        }
        return nil
    }

    /*
     发送警报
     */
    func presentAlert(withTitle title: String, message: String, actions: [AlertAtion], completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let action = UIAlertAction(title: action.title, style: action.style) { action in
                if completionHandler != nil {
                    completionHandler!(action)
                }
            }
            alertController.addAction(action)
        }

        getCurrentViewController()?.present(alertController, animated: true, completion: nil)
    }

    /*
     发送抽屉选项卡
     */
    func presentActionSheet(withTitle title: String, message: String, actions: [AlertAtion], completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            let action = UIAlertAction(title: action.title, style: action.style) { action in
                if let completionHandler {
                    completionHandler(action)
                }
            }
            alertController.addAction(action)
        }

        getCurrentViewController()?.present(alertController, animated: true, completion: nil)
    }

    /*
     发送通知
     */
    func pushNotifi() {
        let content = UNMutableNotificationContent()
        content.title = "⚠️⚠️⚠️专注被打断⚠️⚠️⚠️"
        content.subtitle = ""
        content.body = "20秒内返回转山以保存，或为事件设置应用白名单。否则已有专注时间将蒸发。"
        content.sound = UNNotificationSound.default
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

    /*
     系统分享sheet
     */
    func presentShareSheet(shareitems: [Any]) {
        let activityController = UIActivityViewController(activityItems: shareitems, applicationActivities: nil)
        getCurrentViewController()?.present(activityController, animated: true, completion: nil)
    }

    /*
     截图
     */
    func captureWindow() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: UIScreen.main.bounds.size)
        return renderer.image { _ in
            self.getWindow()?.drawHierarchy(in: UIScreen.main.bounds, afterScreenUpdates: true)
        }
    }

    /*
     发送邮件
     */
    func sendEmail() {
        // Check if the device is able to send email.
        if !MFMailComposeViewController.canSendMail() {
            print("Cannot send email")
            return
        }
        
    }

    /*
     发送动画Tosta
     */
    func popTosta(type: TostaManager.TostaPreset) {
        DispatchQueue.main.async {
            TostaManager.shared.send(type: type)
        }
    }
}
