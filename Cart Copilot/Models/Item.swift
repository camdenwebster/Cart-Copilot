//
//  Item.swift
//  Cart Copilot
//
//  Created by Camden Webster on 2/9/25.
//

import SwiftData
import Foundation

@Model
class Item {
    var id: UUID
    var name: String
    var category: String
    var preferredStore: String
    
    init() {
        self.id = UUID()
        self.name = ""
        self.category = ""
        self.preferredStore = ""
    }
    
    init(id: UUID, name: String, category: String, preferredStore: String) {
        self.id = id
        self.name = name
        self.category = category
        self.preferredStore = preferredStore
    }
}
