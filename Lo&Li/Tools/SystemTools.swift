//
//  Tools.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/20.
//

import CoreHaptics
import UIKit

public enum FeedbackType {
    case success
    case warning
    case error
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
}

/*
 马达震动
 */
public func mada(_ type: FeedbackType) {
    let generator: Any
    switch type {
    case .success:
        generator = UINotificationFeedbackGenerator()
        (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.success)
    case .warning:
        generator = UINotificationFeedbackGenerator()
        (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.warning)
    case .error:
        generator = UINotificationFeedbackGenerator()
        (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.error)
    case .impact(let style):
        generator = UIImpactFeedbackGenerator(style: style)
        (generator as? UIImpactFeedbackGenerator)?.impactOccurred()
    }
}

/*
 喜悦马达
 */
func vibrateForTaskCompletion() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    generator.impactOccurred()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        generator.impactOccurred()
    }
}

/*
 关闭键盘
 */
public func CloseKeyBoard() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
