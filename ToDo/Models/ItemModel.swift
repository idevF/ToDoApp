//
//  ItemModel.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: UUID
    let name: String
    var isCompleted: Bool
    let date: Date
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool, date: Date = Date()) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.date = date
    }
    
}
