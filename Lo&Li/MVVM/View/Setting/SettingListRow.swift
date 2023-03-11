//
//  SettingListRow.swift
//  Naduo
//
//  Created by 赵翔宇 on 2023/2/23.
//

import SwiftUI

struct SettingListRow: View {
    let name: String
    var icon: String
    
    init(name: String, icon: String = "chevrondown") {
        self.name = name
        self.icon = icon
        
    }

    var body: some View {
        HStack {
            Text(name)
                .ndFont(.body1b, color: .f1)
            Spacer()
            ICON(name: icon, fcolor: .f1, size: 18)
                .rotationEffect(.init(degrees: icon == "chevrondown" ? -90 : 0), anchor: .center)
        }
        .padding(.all)
        .addLoliBtnBack()
        .padding(.all,6)
    }
}

struct SettingListRow_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(0 ..< 20) { _ in
                SettingListRow(name: "djaj", icon: "chevrondown")
            }
        }
        .padding(.Naduo.padding18)
    }
}
