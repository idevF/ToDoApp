//
//  ContentView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var listItems: [ItemModel] = [
        ItemModel(name: "Do first !", isCompleted: false),
        ItemModel(name: "Do second !", isCompleted: true),
        ItemModel(name: "Do third", isCompleted: false),
        ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(listItems) { item in
                        ListRowView(item: item)
                            .listRowSeparatorTint(.yellow)
                            .listRowBackground(Color.secondary)
                    }
                } header: {
                    HStack {
                        Text("Business")
                        Image(systemName: "briefcase.fill")
                    }
                    .font(.headline)
                    .foregroundColor(.indigo)
                }
                
                
//                Section {
//                    ForEach(listItems, id: \.self) { item in
//                        HStack {
//                            Image(systemName: "circle")
//                            Text(item)
//                        }
//                    }
//                } header: {
//                    HStack {
//                        Text("Personal")
//                        Image(systemName: "person.fill")
//                    }
//                    .font(.headline)
//                    .foregroundColor(.indigo)
//                }

            }
            .listStyle(.sidebar)
            .navigationTitle("ToDo's")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
