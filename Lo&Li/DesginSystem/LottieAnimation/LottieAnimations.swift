//
//  LottieAnimations.swift
//  TimeMachine (iOS)
//
//  Created by Liseami on 2021/10/16.
//

import SwiftUI

struct LottieAnimations: View {
    let animations: [String] = ["blue_bell", "yellow_bell", "red_bell", "green_bell", "newversion", "focus_success", "FocusOnFailure", "login_animation_json", "26-play-solid-edited"]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            let w = SCREEN_WIDTH
            let columns =
                Array(repeating: GridItem(.fixed(w / 2), spacing: 1), count: 2)
            LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                ForEach(animations, id: \.self.description) { string in
                    Rectangle()
                        .frame(width: w / 2, height: w / 2)
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay(AutoLottieView(lottieFliesName: string, loopMode: .loop)
                            .frame(height: GoldenH))
                }
            }
        }
    }
}

struct LottieAnimations_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimations()
    }
}
