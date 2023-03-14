//
//  ToDoApp.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject private var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(listViewModel)
        }
    }
}
