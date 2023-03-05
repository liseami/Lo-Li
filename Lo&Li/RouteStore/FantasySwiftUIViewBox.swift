//
//  BaseHostingViewController.swift
//  FantasyWindow
//
//  Created by Ze Liang on 2022/3/27.
//

import SwiftUI

/*
 包装全部的SwiftUIView...
 */
class FantasySwiftUIViewBox<Content>: UIHostingController<AnyView>, Routable, UIGestureRecognizerDelegate where Content: View {
    private(set) var route: Route?

    init(content: Content, needCoreDataEnvironment: Bool = false) {
        let context = PersistenceController.shared.container.viewContext
        let contentView = needCoreDataEnvironment ? AnyView(content.environment(\.managedObjectContext, context)) :
            AnyView(content)
        self.route = (content as? Routable)?.getRoute()
        super.init(rootView: contentView)
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     生命周期....
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)

        // 退回到主页面的时候，把导航栏颜色变回b1
        if let vc = RouteStore.shared.navigationController {
            if vc.viewControllers.count <= 1 {
//                changeNavigationBarApp(UINavigationController: vc, changeTo: MakeNaviBarAppearance(color: .b1))
            }
        }
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didMove(toParent parent: UIViewController?) {}
}

class CloudViewBox<Content>: UIHostingController<AnyView>, Routable, UIGestureRecognizerDelegate where Content: View {
    private(set) var route: Route?

    init(content: Content, needCoreDataEnvironment: Bool = false) {
        let context = PersistenceController.shared.container.viewContext
        let contentView = needCoreDataEnvironment ? AnyView(content.environment(\.managedObjectContext, context)) :
            AnyView(content)
        self.route = (content as? Routable)?.getRoute()
        super.init(rootView: contentView)
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     生命周期....
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加下拉关闭手势
        let gestureRecognizer = UIPanGestureRecognizer(target: self,
                                                       action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }

    // 添加下拉关闭手势
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y > initialTouchPoint.y {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = touchPoint.y - initialTouchPoint.y - 56
                }
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > 250 {
                mada(.impact(.soft))
                dismiss(animated: true, completion: {})
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        // 退回到主页面的时候，把导航栏颜色变回b1
        if let vc = RouteStore.shared.navigationController {
            if vc.viewControllers.count <= 1 {
//                changeNavigationBarApp(UINavigationController: vc, changeTo: MakeNaviBarAppearance(color: .b1))
            }
        }
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didMove(toParent parent: UIViewController?) {}
}
