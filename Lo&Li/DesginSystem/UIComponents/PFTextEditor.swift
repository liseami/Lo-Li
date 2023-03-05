//
//  PFTextEditor.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/19.
//

import SwiftUI

struct PFTextEditor: View {
    @Binding var text: String

    var body: some View {

            TextEditor(text: $text)

    }
}

struct PFTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PFTextEditor(text: .constant(""))
    }
}
