//
//  ListViewModel.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    @Published var listItems: [ItemModel] = [] {
        didSet {
            saveListItems()
        }
    }
    
    let keyOfListItems: String = "key_listitems"
    
    init() {
        getListItems()
    }
    
    func getListItems() {
        guard
            let data = UserDefaults.standard.data(forKey: keyOfListItems),
            let decodedData = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.listItems = decodedData
    }
    
    func deleteItem(indexSet: IndexSet) {
        listItems.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        listItems.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(name: String, date: Date) {
        let newItem = ItemModel(name: name, isCompleted: false, date: date)
        listItems.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = listItems.firstIndex(where: { $0.id == item.id}) {
            listItems[index].isCompleted.toggle()
        }
    }
    
    func saveListItems() {
        if let encodedData = try? JSONEncoder().encode(listItems) {
            UserDefaults.standard.set(encodedData, forKey: keyOfListItems)
        }
    }
}
