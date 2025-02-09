//
//  ShoppingItem.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import Foundation
import SwiftData

@Model
final class ShoppingItem {
    var id: UUID
    var name: String
    var category: String
    var store: String
    var quantity: Int
    var amount: Double
    var taxRate: Double
    
    init() {
        self.id = UUID()
        self.name = ""
        self.category = Category.other.rawValue
        self.store = ""
        self.quantity = 1
        self.amount = 0.0
        self.taxRate = 0.0
    }
    
    init(id: UUID = UUID(), name: String, quantity: Int, category: String, amount: Double, taxRate: Double, store: String) {
        self.id = id
        self.name = name
        self.category = category
        self.store = store
        self.quantity = quantity
        self.amount = amount
        self.taxRate = taxRate
    }
}
