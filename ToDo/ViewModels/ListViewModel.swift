//
//  ListViewModel.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    // Saves at any change of listItems.
    @Published var listItems: [ItemModel] = [] {
        didSet {
            saveListItems()
        }
    }
    
    // for Userdefaults
    let keyOfListItems: String = "key_listitems"
    
    // Creates listItems when initialized.
    init() {
        getListItems()
    }
    
    /// Assigns saved data to listItems array.
    ///
    /// This function decodes Userdefaults data which is in JSON format. And then assing the data to listItems array.
    ///
    func getListItems() {
        guard
            let data = UserDefaults.standard.data(forKey: keyOfListItems),
            let decodedData = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.listItems = decodedData
    }
    
    /// Deletes selected item.
    ///
    /// This function removes the item on the listItems array.
    ///
    func deleteItem(indexSet: IndexSet) {
        listItems.remove(atOffsets: indexSet)
    }
    
    /// Moves the selected item.
    ///
    /// This function moves the item in the listItems array.
    ///
    func moveItem(from: IndexSet, to: Int) {
        listItems.move(fromOffsets: from, toOffset: to)
    }
    
    /// Adds a new item.
    ///
    /// This function adds a new item by appending it to  the listItems array.
    ///
    func addItem(name: String) {
        let newItem = ItemModel(name: name, isCompleted: false)
        listItems.append(newItem)
    }
    
    /// Updates list item.
    ///
    /// This functions compares the index of selected item with the items in the listItems array. If the index equality found, the isCompleted Boolean of the array item is toggled.
    /// - Parameter item: Model of item.
    ///
    func updateItem(item: ItemModel) {
        if let index = listItems.firstIndex(where: { $0.id == item.id}) {
            listItems[index].isCompleted.toggle()
        }
    }
    
    /// Saves listItems array to UserDefaults in JSON format.
    ///
    ///  This function encodes listItems array in JSON format. And then saves to UserDefaults.
    ///  - Warning: Userdefaults key is defined as a constant instead of a String parameter.
    ///
    func saveListItems() {
        if let encodedData = try? JSONEncoder().encode(listItems) {
            UserDefaults.standard.set(encodedData, forKey: keyOfListItems)
        }
    }
}
