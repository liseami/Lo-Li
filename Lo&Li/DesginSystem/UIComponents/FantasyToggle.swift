//
//  FantasyToggle.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/2.
//

import SwiftUI

struct FantasyToggle: View {
    @Binding var isOn: Bool
    @Namespace var animation
    var color: Color = .MainColor
    var body: some View {
        Button {
            withAnimation(.spring()) {
                isOn.toggle()
                mada(.impact(.rigid))
            }
        } label: {
            Capsule(style: .continuous)
                .fill(color.opacity(isOn ? 1 : 0.2))
                .frame(width: 47, height: 6, alignment: .center)
                .overlay(alignment: .trailing) {
                    circle
                        .matchedGeometryEffect(id: "toggle", in: animation, properties: .position, anchor: .center, isSource: false)
                        .ifshow(isOn)
                }
                .overlay(alignment: .leading) {
                    circle
                        .matchedGeometryEffect(id: "toggle", in: animation, properties: .position, anchor: .center, isSource: false)
                        .ifshow(!isOn)
                }
                .NaduoShadow(color: .f1.opacity(0.5), style: .s100)
        }
    }

    var circle: some View {
        Circle()
            .fill(Color.b1)
            .frame(width: 24, height: 24, alignment: .center)
            .overlay(alignment: .center, content: {
                Circle().stroke(lineWidth: 0.6)
                    .foregroundColor(.b3)
            })
            .NaduoShadow(color: .f1.opacity(0.3), style: .s300)
    }
}

struct FantasyToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FantasyToggle(isOn: .constant(true))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .isFantasyLabel()
            FantasyToggle(isOn: .constant(false))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .isFantasyLabel()
        }
    }
}
