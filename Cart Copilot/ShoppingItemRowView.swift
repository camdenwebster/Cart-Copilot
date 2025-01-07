//
//  ShoppingItemRowView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftUI

struct ShoppingItemRowView: View {
    var shoppingItem: ShoppingItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(shoppingItem.name)")
                Text("\(shoppingItem.category)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(shoppingItem.amount, format: .currency(code: "USD"))
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ShoppingItemRowView(shoppingItem: ShoppingItem(name: "Test", quantity: 1, category: "Groceries", amount: 0.0, taxRate: 0.0))
}
