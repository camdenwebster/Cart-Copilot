// Add imports
import SwiftUI

struct AppTheme {
    static func apply() {
        // Apply to UINavigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(Color.primaryBackground)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.primaryText)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primaryText)]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        // Apply to TabBar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.primaryBackground)
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

// End of file. No additional code.
