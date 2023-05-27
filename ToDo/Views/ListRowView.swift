//
//  ListRowView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    @State var textBackgroundColor: Color = Color(uiColor: .systemGray5)
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(item.isCompleted ? Color(uiColor: .systemGreen) : Color(uiColor: .systemOrange))
                .padding(.leading)
            
            Text(item.name)
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                .strikethrough(item.isCompleted ? true : false, color: .red)
        }
        .font(.headline)
        .background(textBackgroundColor)
        .cornerRadius(10)
        .shadow(color: Color(uiColor: .systemGray), radius: 3)
        .opacity(item.isCompleted ? 0.5 : 1.0)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ListRowView(item: ItemModel(name: "first", isCompleted: false)).padding()
            ListRowView(item: ItemModel(name: "second", isCompleted: true)).padding()
        }
    }
}
