//
//  UIState.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2022/10/22.
//

import Foundation

class UIState: ObservableObject {
    init(currentDetail: DetailViewType = .chat) {
        self.currentDetail = currentDetail
    }

    enum DetailViewType: CaseIterable {
        case chat, setting
//        var iteminfo: ItemInfo {
//            switch self {
//            case .home:
//                return .init(title: "主页", icon: "home")
//            case .cloud:
//                return .init(title: "云朵", icon: "cloud")
//            case .add:
//                return .init(title: "添加", icon: "plus")
//            case .search:
//                return .init(title: "搜索", icon: "find")
//            case .workbench:
//                return .init(title: "我的", icon: "myitems")
//            }
//        }
    }

    @Published var currentDetail: DetailViewType = .chat
    @Published var columnVisibility =
    NavigationSplitViewVisibility.all
}
