//
//  Routable.swift
//  FantasyWindow
//
//  Created by Ze Liang on 2022/3/27.
//

import SwiftUI
import UIKit

protocol Routable {
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode { get }
    var presentationControllerShouldDismiss: Bool { get }
}

extension Routable {
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        .none
    }

    var presentationControllerShouldDismiss: Bool {
        false
    }

    func getRoute() -> Route {
        Route(
            keyboardDismissMode: keyboardDismissMode,
            presentationControllerShouldDismiss: presentationControllerShouldDismiss
        )
    }
}

struct Route {
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none
    var presentationControllerShouldDismiss: Bool = false
}
