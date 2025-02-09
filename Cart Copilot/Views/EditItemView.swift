//
//  EditItemView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/3/25.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Bindable var shoppingItem: ShoppingItem
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategory: Category = .produce

    var body: some View {
        NavigationStack {
            Form {
                TextField("Eggs, milk, etc", text: $shoppingItem.name)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
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
    EditItemView(shoppingItem: ShoppingItem())
}
