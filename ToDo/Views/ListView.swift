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
        NavigationStack {
            VStack {
                // If the list is Empty, NoItemsView appears
                if listViewModel.listItems.isEmpty {
                    NoItemsView()
                
                // else the item List appears
                } else {
                    // hides and shows completed items
                    toggleButton
                    myListViewSection
                }
            }
            .navigationTitle("ToDo")
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
        Toggle(isOn: $toggleIsOn.animation()) {
            Text("Hide completed")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .tint(.accentColor)
        .padding(.horizontal)
    }
    
    private var myListViewSection: some View {
        List {
            Section {
                itemList
            } header: {
                sectionHeader
            }
            .listSectionSeparator(.visible)
        }
        .listStyle(.plain)
    }
    
    /// This is the layer that shows items depending on the logic of filtered list computed property
    private var itemList: some View {
        ForEach(filteredListITems) { item in
            ListRowView(item: item)
                .listRowSeparator(.hidden)
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
