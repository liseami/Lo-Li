//
//  ContentView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var userManager: UserManager = .shared
    @ObservedObject var uistate: UIState = .shared
    @Environment(\.colorScheme) private var systemColorSheme

    var body: some View {
        Group {
            if userManager.logged {
                MainView()
            } else {
                TokenGetView()
            }
        }
        .environment(\.colorScheme,
                     uistate.ColorShemeModel == 0 ? systemColorSheme :
                         uistate.ColorShemeModel == 1 ? .light : .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
