//
//  PageSection.swift
//  Naduo
//
//  Created by 赵翔宇 on 2023/1/30.
//

import SwiftUI

struct PageSection<Content>: View where Content: View {
    let type: SectionType
    let content: () -> Content
    let title: String
    let iconname: String?

    enum SectionType {
        case large(title: String)
        case small(title: String, iconname: String?)
    }

    init(type: SectionType, @ViewBuilder content: @escaping () -> Content) {
        self.type = type
        switch type {
        case let .large(title):
            self.title = title
            self.iconname = nil
        case let .small(title, iconname):
            self.title = title
            self.iconname = iconname
        }
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .Naduo.padding24) {
            switch self.type {
            case .small:
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        if let iconname {
                            ICON(name: iconname, fcolor: .f2, size: 18)
                        }
                        Text(title)
                            .ndFont(.body3, color: .f2)
                    }
                    Line()
                }
            case .large:
                Text(self.title)
                    .ndFont(.t2b, color: .f1)
                    .PF_Leading()
            }
            content()
        }
    }
}

struct PageSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .Naduo.padding32) {
            PageSection(type: .large(title: "大标题")) {
                Text("大标题")
            }
            PageSection(type: .small(title: "SmallSection", iconname: "myclouds")) {
                Text("小标题带ICON")
            }
            PageSection(type: .small(title: "小标题不带ICON", iconname: nil)) {
                Text("小标题不带ICON")
            }
        }.padding(.horizontal, 18)
    }
}
