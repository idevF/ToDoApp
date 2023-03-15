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
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
}
