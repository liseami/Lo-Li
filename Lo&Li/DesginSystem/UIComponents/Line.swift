//
//  PublicComponents.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/2/10.
//

import SwiftUI

struct Line: View {
    let color: Color
    let height: CGFloat 
    init(color: Color = .l1, height: CGFloat = 0.6) {
        self.color = color
        self.height = height
    }

    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(height: height)
            
    }
}

struct PublicComponents_Previews: PreviewProvider {
    static var previews: some View {
        Line()
    }
}
