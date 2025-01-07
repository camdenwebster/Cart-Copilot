//
//  NewItemView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftUI

struct NewItemView: View {
    @State private var name = ""
    @State private var category = "Groceries"
    @State private var priceText = ""
    @State private var taxRate = 0.0
    @State private var quantity = 1
    @Environment(\.dismiss) var dismiss
    
    var shoppingItems: ShoppingItems
    let categories = ["Groceries", "Personal Care", "Baby Care", "Home Decor", "Cleaning Supplies"]
    

    private var amount: Double? {
        if let value = Double(priceText.filter({ "0123456789.".contains($0) })) {
            return value
        }
        return nil
    }
    
    init(shoppingItems: ShoppingItems) {
        self.shoppingItems = shoppingItems
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Eggs, milk, etc", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                Stepper("\(quantity)", value: $quantity, in: 1...100, step: 1)
                HStack {
                    Text("$")
                    Spacer()
                    TextField("Price", text: $priceText)
                        .keyboardType(.decimalPad)
//                        .onChange(of: priceText) {
//                            if let value = amount {
//                                priceText = value.formatted(.currency(code: "USD"))
//                            }
//                        }
                        .frame(alignment: .trailing)
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        guard let validAmount = amount else { return }
                        let item = ShoppingItem(name: name, quantity: quantity, category: category, amount: validAmount, taxRate: taxRate)
                        shoppingItems.items.append(item)
                        dismiss()
                    }
                    .bold()
                    .disabled(amount == nil)
                }
            }
        }
    }
}

#Preview {
    NewItemView(shoppingItems: ShoppingItems())
}
