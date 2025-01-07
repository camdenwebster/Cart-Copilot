//
//  EditItemView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/3/25.
//

import SwiftUI

struct EditItemView: View {
    @Binding var shoppingItem: ShoppingItem
    @Environment(\.dismiss) var dismiss
    
    let categories = ["Groceries", "Personal Care", "Baby Care", "Home Decor", "Cleaning Supplies"]
    

    var body: some View {
        NavigationStack {
            Form {
                TextField("Eggs, milk, etc", text: $shoppingItem.name)
                Picker("Category", selection: $shoppingItem.category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                Stepper("\(shoppingItem.quantity)", value: $shoppingItem.quantity, in: 1...100, step: 1)
                TextField("Price", value: $shoppingItem.amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
}

#Preview {
    EditItemView(shoppingItem: .constant(ShoppingItem(name: "Test", quantity: 1, category: "Groceries", amount: 0.0, taxRate: 0.0)))
}
