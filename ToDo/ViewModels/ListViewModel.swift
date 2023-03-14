//
//  ListViewModel.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    @Published var listItems: [ItemModel] = []
    
    init() {
        getListItems()
    }
    
    func getListItems() {
        let newItems = [
            ItemModel(name: "Do first !", isCompleted: false),
            ItemModel(name: "Do second !", isCompleted: true),
            ItemModel(name: "Do third", isCompleted: false),
            ]
        listItems.append(contentsOf: newItems)
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
    
    func updateItem(item: ItemModel) {
        if let index = listItems.firstIndex(where: { $0.id == item.id}) {
            listItems[index].isCompleted.toggle()
        }
    }
}
