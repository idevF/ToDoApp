//
//  ListView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var listViewModel: ListViewModel
    
    @State private var toggleIsOn: Bool = false
    
    private var filteredListITems: [ItemModel] {
        listViewModel.listItems.filter { item in
            (!toggleIsOn || !item.isCompleted)
        }
    }
    
    @State private var rowBackgroundColor: Color = Color(uiColor: .systemGray5)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                
                if listViewModel.listItems.isEmpty {
                    NoItemsView()
                } else {
                    List {
                        Section {
                            Toggle(isOn: $toggleIsOn) {
                                Text("Hide Completed")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .tint(.accentColor)

                            ForEach(filteredListITems) { item in
                                ListRowView(item: item)
                                    .listRowSeparatorTint(.orange)
                                    .listRowBackground(rowBackgroundColor)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.7)) {
                                            listViewModel.updateItem(item: item)
                                        }
                                    }
                            }
                            .onDelete(perform: listViewModel.deleteItem)
                            .onMove(perform: listViewModel.moveItem)
                        } header: {
                            HStack {
                                Text("My list")
                                Image(systemName: "briefcase.fill")
                            }
                            .font(.headline)
                            .foregroundColor(.accentColor)
                        }

                    }
                    .listStyle(.insetGrouped)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListViewModel())
    }
}
