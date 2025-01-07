//
//  ShoppingItemDetailView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftUI

struct ShoppingItemDetailView: View {
    // Change to @Binding to allow modifications
    @Binding var shoppingItem: ShoppingItem
    @State private var showingEditItem = false
    
    var body: some View {
        Form {
            HStack {
                Text("Category")
                Spacer()
                Text("\(shoppingItem.category)")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Quantity")
                Spacer()
                Text("\(shoppingItem.quantity)")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Price")
                Spacer()
                Text(shoppingItem.amount, format: .currency(code: "USD"))
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("\(shoppingItem.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditItem = true
                }
                
            }
        }
        .sheet(isPresented: $showingEditItem) {
            EditItemView(shoppingItem: $shoppingItem)
        }
    }
}

#Preview {
    ShoppingItemDetailView(shoppingItem: .constant(ShoppingItem(name: "Test", quantity: 1, category: "Groceries", amount: 0.0, taxRate: 0.0)))
}
