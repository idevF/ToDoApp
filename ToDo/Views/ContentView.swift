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
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
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
            .navigationTitle("ToDo")
            .navigationBarItems(leading: EditButton(),
                                trailing:
                                    NavigationLink("Add", destination: AddView())
//                                    Button("Add") { addItem(name: "new") }
            )
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        listItems.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        listItems.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(name: String) {
        let newItem = ItemModel(name: name, isCompleted: false)
        listItems.append(newItem)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
