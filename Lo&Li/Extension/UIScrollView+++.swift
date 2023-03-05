//
//  UIScrollView+++.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/19.
//

import Foundation

extension UIScrollView {
    func scrollowToBottom(animated: Bool = false) {
        guard contentSize.height > SCREEN_HEIGHT * 0.6 else { return }
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - SCREEN_HEIGHT)
        setContentOffset(bottomOffset, animated: animated)
    }
}
