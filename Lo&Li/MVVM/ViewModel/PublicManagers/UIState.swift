//
//  UIState.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2022/10/22.
//

import Foundation

class UIState: ObservableObject {
    static let shared: UIState = .init()

    @AppStorage("ColorShemeModel") var ColorShemeModel: Int = 0{
        didSet {
            self.objectWillChange.send()
        }
    }
    
//    @Published var columnVisibility =
//        NavigationSplitViewVisibility.all
}
