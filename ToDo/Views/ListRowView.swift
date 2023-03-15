//
//  ListRowView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isCompleted ? .green : .yellow)
            Text(item.name)
                .opacity(item.isCompleted ? 0.3 : 1.0)
                .strikethrough(item.isCompleted ? true : false, color: .red)
                
            Spacer()
        }
        .font(.subheadline)
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
