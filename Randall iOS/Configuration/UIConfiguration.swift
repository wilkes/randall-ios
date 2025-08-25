import SwiftUI

// MARK: - UI Configuration
/// Centralized configuration for UI layout values
struct UIConfiguration {
    
    // MARK: - Grid Configuration
    struct Grid {
        static let defaultColumnCount = 3
        static let triadColumnCount = 4
        static let twelveKeysColumnCount = 4
        static let defaultSpacing: CGFloat = 12
        static let defaultItemHeight: CGFloat = 60
        static let triadItemHeight: CGFloat = 50
    }
    
    // MARK: - Spacing Configuration
    struct Spacing {
        static let extraSmall: CGFloat = 2
        static let small: CGFloat = 6
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 20
        static let xxlarge: CGFloat = 24
        static let xxxlarge: CGFloat = 40
    }
    
    // MARK: - Corner Radius Configuration
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 10
        static let large: CGFloat = 12
    }
    
    // MARK: - Padding Configuration
    struct Padding {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let horizontal: CGFloat = 20
        static let vertical: CGFloat = 12
    }
    
    // MARK: - Frame Configuration
    struct Frame {
        static let iconWidth: CGFloat = 24
        static let topPadding: CGFloat = 40
    }
    
    // MARK: - Exercise-Specific Configuration
    struct Exercise {
        static let defaultItemCount = 12
        static let randomItemCount = 5
    }
    
    // MARK: - Animation Configuration
    struct Animation {
        static let defaultDuration: Double = 0.4
        static let quickDuration: Double = 0.1
        static let slowDuration: Double = 0.6
        
        static let defaultEasing: SwiftUI.Animation = .easeInOut(duration: defaultDuration)
        static let quickEasing: SwiftUI.Animation = .easeInOut(duration: quickDuration)
        static let slowEasing: SwiftUI.Animation = .easeInOut(duration: slowDuration)
        
        static let beatIndicator: SwiftUI.Animation = .easeInOut(duration: quickDuration)
    }
}

// MARK: - Exercise Layout Configuration
/// Exercise-specific layout configurations
struct ExerciseLayoutConfig {
    let columnCount: Int
    let itemHeight: CGFloat
    let spacing: CGFloat
    
    // MARK: - Predefined Configurations
    static let randomSeventhChords = ExerciseLayoutConfig(
        columnCount: UIConfiguration.Grid.defaultColumnCount,
        itemHeight: UIConfiguration.Grid.defaultItemHeight,
        spacing: UIConfiguration.Grid.defaultSpacing
    )
    
    static let randomTriads = ExerciseLayoutConfig(
        columnCount: UIConfiguration.Grid.triadColumnCount,
        itemHeight: UIConfiguration.Grid.triadItemHeight,
        spacing: UIConfiguration.Grid.defaultSpacing
    )
    
    static let twelveKeys = ExerciseLayoutConfig(
        columnCount: UIConfiguration.Grid.twelveKeysColumnCount,
        itemHeight: UIConfiguration.Grid.defaultItemHeight,
        spacing: UIConfiguration.Grid.defaultSpacing
    )
    
    static let `default` = ExerciseLayoutConfig(
        columnCount: UIConfiguration.Grid.defaultColumnCount,
        itemHeight: UIConfiguration.Grid.defaultItemHeight,
        spacing: UIConfiguration.Grid.defaultSpacing
    )
}

// MARK: - Theme Configuration
/// Color and visual theme configuration
struct ThemeConfiguration {
    
    // MARK: - Colors
    struct Colors {
        static let cardBackground = "cardBackground"
        static let primaryText = "primaryText"
        static let secondaryText = "secondaryText"
        static let accent = "accentColor"
    }
    
    // MARK: - Font Sizes
    struct FontSize {
        static let title: CGFloat = 18
        static let body: CGFloat = 16
        static let caption: CGFloat = 14
        static let small: CGFloat = 12
    }
}
