//
//  Public.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/7/7.
//

import Foundation

struct ItemInfo {
    var title: String = ""
    var icon: String = ""
    var color: Color = .f1
    init(title: String, icon: String, color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }

    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }

    init(title: String) {
        self.title = title
    }

    init() {}
}

struct SettingSection: Identifiable {
    var id = UUID()
    var title: String = ""
    var items: [SettingItemInfo] = []
    init(title: String, items: [SettingItemInfo]) {
        self.title = title
        self.items = items
    }
}

struct SettingItemInfo: Identifiable {
    var id: UUID = .init()
    var left: ItemInfo = .init()
    var right: ItemInfo = .init()

    init(left: ItemInfo, right: ItemInfo) {
        self.left = left
        self.right = right
    }

    init(left: ItemInfo) {
        self.left = left
    }
}

struct PageNum: Convertible {
    var pageNum: Int = 1
}

public struct AlertAtion {
    var title: String
    var style: UIAlertAction.Style
}
