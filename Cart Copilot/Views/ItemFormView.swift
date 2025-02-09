// Add imports
import SwiftUI
import SwiftData

struct ItemFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    // If item is nil, we're creating a new item
    var item: ShoppingItem?
    @State private var name = ""
    @State private var quantity = 1
    @State private var amount = 0.0
    @State private var selectedCategory = Category.other
    @State private var selectedStore = Store.other
    @State private var taxRate = 0.0
    
    private var isEditing: Bool {
        item != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                Picker("Store", selection: $selectedStore) {
                    ForEach(Store.allCases, id: \.self) { store in
                        Text(store.rawValue)
                    }
                }
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                TextField("Price", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                TextField("Tax Rate", value: $taxRate, format: .percent)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle(isEditing ? "Edit Item" : "New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveItem()
                        dismiss()
                    }
                    .bold()
                }
            }
            .onAppear {
                if let existingItem = item {
                    name = existingItem.name
                    quantity = existingItem.quantity
                    amount = existingItem.amount
                    selectedCategory = Category(rawValue: existingItem.category) ?? .other
                    taxRate = existingItem.taxRate
                }
            }
        }
    }
    
    private func saveItem() {
        if let existingItem = item {
            // Update existing item
            existingItem.name = name
            existingItem.quantity = quantity
            existingItem.amount = amount
            existingItem.category = selectedCategory.rawValue
            existingItem.taxRate = taxRate
        } else {
            // Create new item
            let newItem = ShoppingItem(
                name: name,
                quantity: quantity,
                category: selectedCategory.rawValue,
                amount: amount,
                taxRate: taxRate,
                store: selectedStore.rawValue
            )
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ItemFormView()
        .modelContainer(for: ShoppingItem.self)
}

// End of file. No additional code.
