//
//  ListView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListView: View {
    
    // MARK: PROPERTIES
    
    @EnvironmentObject private var listViewModel: ListViewModel
    
    @State private var toggleIsOn: Bool = false
    
    /// This computed property filters completed items in the list
    private var filteredListITems: [ItemModel] {
        listViewModel.listItems.filter { item in
            (!toggleIsOn || !item.isCompleted)
        }
    }

    
    // MARK: BODY
    
    var body: some View {
        NavigationView {
            ZStack {
                // If the list is Empty, NoItemsView appears
                if listViewModel.listItems.isEmpty {
                    NoItemsView()
                
                // else the item List appears
                } else {
                    List {
                        Section {
                            // hides and shows completed items
                            toggleButton
                            
                            // list of items
                            itemList
                        } header: {
                            sectionHeader
                        }
                    }
                    .listStyle(.insetGrouped)
                    .animation(.default, value: toggleIsOn)
                }
            }
            .navigationTitle("ToDo")
            .navigationViewStyle(.stack) // for iPad
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Add", destination: AddView())
            )
        }
    }
}

// MARK: PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListViewModel())
    }
}

// MARK: COMPONENTS

extension ListView {
    // toggle button to select hide or show completed items
    private var toggleButton: some View {
        Toggle(isOn: $toggleIsOn) {
            Text("Hide Completed")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .tint(.accentColor)
    }
    
    /// This is the layer that shows items depending on the logic of filtered list computed property
    private var itemList: some View {
        ForEach(filteredListITems) { item in
            ListRowView(item: item)
                .listRowSeparatorTint(Color(uiColor: .systemOrange))
                .listRowBackground(Color(uiColor: .systemGray5))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        listViewModel.updateItem(item: item)
                    }
                }
        }
        .onDelete(perform: listViewModel.deleteItem)
        .onMove(perform: listViewModel.moveItem)
    }
    
    // section header
    private var sectionHeader: some View {
        HStack {
            Text("My list")
            Image(systemName: "briefcase.fill")
        }
        .font(.headline)
        .foregroundColor(.accentColor)
    }
}
