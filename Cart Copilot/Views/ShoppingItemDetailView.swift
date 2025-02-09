//
//  ShoppingItemDetailView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftUI

struct ShoppingItemDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var shoppingItem: ShoppingItem
    @State private var isEditing = false
    
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
                    isEditing = true
                }
                
            }
        }
        .sheet(isPresented: $isEditing) {
            ItemFormView(item: shoppingItem)
        }
    }
}

#Preview {
    ShoppingItemDetailView(shoppingItem: ShoppingItem())
}
