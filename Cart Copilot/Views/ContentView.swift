//
//  ContentView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var shoppingItems: [ShoppingItem]
    @State private var path = NavigationPath()
    @State private var showingNewItem = false
    
    var subtotal: Double {
        shoppingItems.reduce(0) { $0 + $1.amount }
    }
    
    var tax: Double {
        subtotal * 0.08
    }
    
    var total: Double {
        subtotal + tax
    }
    
    var formattedSubtotal: String {
        subtotal.formatted(.currency(code: "USD"))
    }
    
    var formattedTax: String {
        tax.formatted(.currency(code: "USD"))
    }
    
    var formattedTotal: String {
        total.formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Subtotal:")
                        Spacer()
                        Text(formattedSubtotal)
                    }
                    HStack {
                        Text("Tax (8%):")
                        Spacer()
                        Text(formattedTax)
                    }
                    HStack {
                        Text("Total Items:")
                        Spacer()
                        Text("\(shoppingItems.count)")
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                List {
                    ForEach(shoppingItems) { item in
                        NavigationLink(value: item) {
                            ShoppingItemRowView(shoppingItem: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle(formattedTotal)
            .navigationDestination(for: ShoppingItem.self) { item in
                let index = shoppingItems.firstIndex(where: { $0.id == item.id })!
                ShoppingItemDetailView(shoppingItem: shoppingItems[index])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewItem = true
                    } label: {
                        Label("Show settings menu", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewItem) {
            ItemFormView()
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = shoppingItems[offset]
            modelContext.delete(item)
        }
    }
    
}

#Preview {
    ContentView()
}
