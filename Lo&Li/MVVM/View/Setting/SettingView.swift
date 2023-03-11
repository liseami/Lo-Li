//
//  SettingView.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct SettingView: View {
    @StateObject var vm: SettingViewModel = .init()

    var body: some View {
        VStack(spacing: .Naduo.padding32) {
            brand
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .Naduo.padding32) {
                    ForEach(vm.settingGroup, id: \.name) { group in
                        PageSection(type: .small(title: group.name, iconname: nil)) {
                            VStack(alignment: .leading, spacing: .Naduo.padding8) {
                                if let items = group.children {
                                    ForEach(items, id: \.name) { item in
                                        
                                        NavigationLink {
                                            switch item.name {
                                            case "Token":
                                                TokenGetView()
                                            case "模型选择":
                                               ModelListView()
                                            case "颜色模式":
                                                ColorShemePicker()
                                            default: EmptyView()
                                            }
                                        } label: {
                                            SettingListRow(name: item.name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.all)
    }

    var brand: some View {
        VStack(alignment: .leading, spacing: .Naduo.padding8) {
            Text("Lo&Li 设置")
                .ndFont(.t1b, color: .f1)
                .PF_Leading()
            Text("V1.0.1")
                .ndFont(.c1, color: .f2)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .isPreview(.sheet)
    }
}
