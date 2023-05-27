//
//  ListRowView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    @State var textBackgroundColor: Color = Color(uiColor: .systemGray4)
    
    var body: some View {
        HStack(alignment: .top) {
            // checkmark stack
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isCompleted ? Color(uiColor: .systemGreen) : Color(uiColor: .systemOrange))
                .font(.headline)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
            
            // text and due date stack
            VStack(alignment: .leading, spacing: 8.0) {
                Text(item.name)
            }
            .frame(maxWidth: .infinity)
            .font(.subheadline)
            .padding(10)
            .background(
                textBackgroundColor
            )
            .cornerRadius(10)
            .shadow(color: Color(uiColor: .systemGray), radius: 3)
            .opacity(item.isCompleted ? 0.3 : 1.0)
            .strikethrough(item.isCompleted ? true : false, color: .red)
            Spacer()
        }
        .fontWeight(.semibold)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ListRowView(item: ItemModel(name: "first", isCompleted: false))
            ListRowView(item: ItemModel(name: "second", isCompleted: true))
        }
    }
}
