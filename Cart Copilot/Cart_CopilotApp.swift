//
//  Cart_CopilotApp.swift
//  Cart Copilot
//
//  Created by Camden Webster on 1/1/25.
//

import SwiftData
import SwiftUI

@main
struct Cart_CopilotApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Item.self, ShoppingItem.self])
    }
}
