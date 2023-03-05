//
//  Typography.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI

public struct NDFont: ViewModifier {
    enum Style {
        /// T 标题
        case tt, t1, t2, ttb, t1b, t2b
        
        /// B 正文
        case body1, body2, body1b, body2b, body3, body3b
        
        /// C 辅助
        case c1, c2, c1b, c2b
    }
    
    var style: Style
    
    public func body(content: Content) -> some View {
        switch self.style {
        case .tt: return content.font(.system(size: 36, weight: .regular, design: .rounded))
        case .t1: return content.font(.system(size: 24, weight: .regular, design: .rounded))
        case .t2: return content.font(.system(size: 20, weight: .regular, design: .rounded))
        case .ttb: return content.font(.system(size: 36, weight: .bold, design: .rounded))
        case .t1b: return content.font(.system(size: 24, weight: .bold, design: .rounded))
        case .t2b: return content.font(.system(size: 20, weight: .bold, design: .rounded))
            
        case .body1: return content.font(.system(size: 18, weight: .regular, design: .rounded))
        case .body2: return content.font(.system(size: 16, weight: .regular, design: .rounded))
        case .body3: return content.font(.system(size: 14, weight: .regular, design: .rounded))
        case .body1b: return content.font(.system(size: 18, weight: .bold, design: .rounded))
        case .body2b: return content.font(.system(size: 16, weight: .bold, design: .rounded))
        case .body3b: return content.font(.system(size: 14, weight: .bold, design: .rounded))
            
        case .c1: return content.font(.system(size: 11, weight: .regular, design: .rounded))
        case .c2: return content.font(.system(size: 9, weight: .regular, design: .rounded))
        case .c1b: return content.font(.system(size: 11, weight: .bold, design: .rounded))
        case .c2b: return content.font(.system(size: 9, weight: .bold, design: .rounded))
        }
    }
}

extension View {
    func ndFont(_ style: NDFont.Style) -> some View {
        self.modifier(NDFont(style: style))
    }
    
    func ndFont(_ style: NDFont.Style, color: Color) -> some View {
        self
            .modifier(NDFont(style: style))
            .foregroundColor(color)
    }
}

struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            Group {
                Text("Typography t1").ndFont(.t1)
                Text("Typography t2").ndFont(.t2)
                Text("Typography h1").ndFont(.t1)
            }
        }
    }
}
