//
//  ConversationRow.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import SwiftUI

struct ConversationRow: View {
    var selected : Bool = false
    var body: some View {
        HStack {
            Text("会话")
                .ndFont(.body1,color: .f1)
            Spacer()
        }
        .padding(.all, 12)
        .addBack(cornerRadius: 10, backGroundColor: .b1, strokeLineWidth: 0, strokeFColor: .clear)
        .NaduoShadow(color: .f2, style: .s300)
        .NaduoShadow(color: .f3, style: .s100)
        .padding(.all, 3)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: selected ? 3 : 1.5)
                .fill( selected ? Color.teal.opacity(0.3).gradient : Color.f2.opacity(0.3).gradient)
        }
        .padding(.all, 3)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(lineWidth: 4)
                .fill(selected ? Color.teal.opacity(0.1).gradient : Color.f3.opacity(0.3).gradient)
        }
    }
}

struct ConversationRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ConversationRow()
            ConversationRow(selected: true)
        }
        .padding(.horizontal,100)
    }
}
