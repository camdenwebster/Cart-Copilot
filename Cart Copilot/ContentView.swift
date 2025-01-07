//
//  ContentView.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    @State private var shoppingItems = ShoppingItems()
    @State private var showingNewItem = false
    
    var subtotal: Double {
        shoppingItems.items.reduce(0) { $0 + $1.amount }
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
        NavigationStack(path: $pathStore.path) {
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
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                List {
                    ForEach(shoppingItems.items) { item in
                        NavigationLink(value: item) {
                            ShoppingItemRowView(shoppingItem: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle(formattedTotal)
            .navigationDestination(for: ShoppingItem.self) { item in
                let index = shoppingItems.items.firstIndex(where: { $0.id == item.id })!
                ShoppingItemDetailView(shoppingItem: $shoppingItems.items[index])
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
            NewItemView(shoppingItems: shoppingItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        shoppingItems.items.remove(atOffsets: offsets)
    }
    
}

#Preview {
    ContentView()
}
