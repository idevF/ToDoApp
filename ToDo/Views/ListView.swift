//
//  ListView.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var listViewModel: ListViewModel
    
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
                            ForEach(listViewModel.listItems) { item in
                                ListRowView(item: item)
                                    .listRowSeparatorTint(.yellow)
                                    .listRowBackground(Color.gray.opacity(0.9))
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
                                Text("Business")
                                Image(systemName: "briefcase.fill")
                            }
                            .font(.headline)
                            .foregroundColor(.accentColor)
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
