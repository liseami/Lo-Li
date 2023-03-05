//
//  PFSheetSection.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/2.
//

import SwiftUI

struct PFSection<Content>: View where Content: View {
    let title: String
    let content: () -> Content

    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .ndFont(.body1,color: .f2)
                .PF_Leading()
            content()
        }
        
    }
}

struct PFSheetSection_Previews: PreviewProvider {
    static var previews: some View {
        PFSection(title: "PFSECTION") {
//            TextBtn(title: "PFSEECTIO") {}
        }
    }
}
