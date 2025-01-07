//
//  ShoppingItem.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import Foundation

struct ShoppingItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var quantity: Int
    var category: String
    var amount: Double
    var taxRate: Double
}

@Observable
class ShoppingItems {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "ShoppingItems") {
            if let decoded = try? JSONDecoder().decode([ShoppingItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        
        items = []
    }
    
    var items = [ShoppingItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ShoppingItems")
            }
        }
    }
}
