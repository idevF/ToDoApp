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
            List {
                Section {
                    ForEach(listViewModel.listItems) { item in
                        ListRowView(item: item)
                            .listRowSeparatorTint(.yellow)
                            .listRowBackground(Color.secondary)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
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
