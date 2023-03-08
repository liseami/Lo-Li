//
//  ColorShemePicker.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/9.
//

import SwiftUI

struct ColorShemePicker: View {
    @AppStorage("ColorShemeModel") var ColorShemeModel: Int = 0

    var body: some View {
        VStack {
            Group {
                ForEach(0 ..< 3) { index in
                    let selected = index == ColorShemeModel
                    HStack {
                        Text(index == 0 ? "跟随系统" : index == 1 ? "白天模式" : "黑夜模式")
                        Spacer()
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.teal)
                            .frame(width: 24, height: 24, alignment: .center)
                            .overlay(Circle()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.teal)
                                .ifshow(selected),
                                alignment: .center)
                    }
                    .background(Color.b1)
                    .onTapGesture(count: 1) {
                        ColorShemeModel = index
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .addGoldenPadding()
            .addLoliBtnBack()
            Spacer()
        }
        .addGoldenPadding()
    }
}

struct ColorShemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorShemePicker()
    }
}
