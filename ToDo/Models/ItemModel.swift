//
//  ItemModel.swift
//  ToDo
//
//  Created by idevF on 14.03.2023.
//

import Foundation

struct ItemModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let isCompleted: Bool
}
