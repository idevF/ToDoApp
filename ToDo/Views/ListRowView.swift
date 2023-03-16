//
//  ListRowView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    @State private var textBackgroundColor: Color = Color(uiColor: .systemGray4)
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isCompleted ? .green : .orange)
                .font(.headline)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(item.name)

                Text("Due: " + item.date.formatted(date: .long, time: .shortened))
                    .fontWeight(.light)
            }
            .font(.subheadline)
            .padding(10)
            .background(item.date < Date() ? Color(uiColor: .systemRed).opacity(0.7) : textBackgroundColor)
            .cornerRadius(10)
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
