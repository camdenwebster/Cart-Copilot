// Add imports
import SwiftUI

extension Color {
    // Primary Colors (60%)
    static let primaryBackground = Color(light: "F5F5F5", dark: "1A1A1A")
    static let primaryText = Color(light: "2C3E50", dark: "ECF0F1")
    
    // Secondary Colors (30%)
    static let secondaryAccent = Color(light: "3498DB", dark: "2980B9")
    static let secondaryBackground = Color(light: "ECF0F1", dark: "2C3E50")
    
    // Accent Colors (10%)
    static let accent = Color(light: "27AE60", dark: "2ECC71")
    static let accentDanger = Color(light: "E74C3C", dark: "FF6B6B")
    
    // Helper initializer for light/dark variants
    init(light: String, dark: String) {
        self.init(uiColor: UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(Color(hex: dark))
            } else {
                return UIColor(Color(hex: light))
            }
        })
    }
    
    // Helper initializer for hex colors
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// End of file. No additional code.
