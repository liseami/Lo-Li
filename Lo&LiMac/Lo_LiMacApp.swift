//
//  Lo_LiMacApp.swift
//  Lo&LiMac
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

@main
struct Lo_LiMacApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
