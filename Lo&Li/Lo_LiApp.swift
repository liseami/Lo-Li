//
//  Lo_LiApp.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

@_exported import Combine
@_exported import SwiftUI

@main
struct Lo_LiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
