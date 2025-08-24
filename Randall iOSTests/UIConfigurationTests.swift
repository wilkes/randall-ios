import Testing
@testable import Randall_iOS

// MARK: - UI Configuration Tests
struct UIConfigurationTests {
    
    @Test("Grid configuration has valid values")
    func gridConfigurationValues() {
        #expect(UIConfiguration.Grid.defaultColumnCount > 0)
        #expect(UIConfiguration.Grid.triadColumnCount > 0)
        #expect(UIConfiguration.Grid.twelveKeysColumnCount > 0)
        #expect(UIConfiguration.Grid.defaultSpacing > 0)
        #expect(UIConfiguration.Grid.defaultItemHeight > 0)
        #expect(UIConfiguration.Grid.triadItemHeight > 0)
    }
    
    @Test("Spacing configuration has positive values")
    func spacingConfigurationValues() {
        #expect(UIConfiguration.Spacing.extraSmall > 0)
        #expect(UIConfiguration.Spacing.small > 0)
        #expect(UIConfiguration.Spacing.medium > 0)
        #expect(UIConfiguration.Spacing.large > 0)
        #expect(UIConfiguration.Spacing.extraLarge > 0)
        #expect(UIConfiguration.Spacing.xxlarge > 0)
        #expect(UIConfiguration.Spacing.xxxlarge > 0)
    }
    
    @Test("Corner radius configuration has valid values")
    func cornerRadiusConfigurationValues() {
        #expect(UIConfiguration.CornerRadius.small > 0)
        #expect(UIConfiguration.CornerRadius.medium > 0)
        #expect(UIConfiguration.CornerRadius.large > 0)
        
        // Ensure logical ordering
        #expect(UIConfiguration.CornerRadius.small < UIConfiguration.CornerRadius.medium)
        #expect(UIConfiguration.CornerRadius.medium < UIConfiguration.CornerRadius.large)
    }
    
    @Test("Padding configuration has positive values")
    func paddingConfigurationValues() {
        #expect(UIConfiguration.Padding.small > 0)
        #expect(UIConfiguration.Padding.medium > 0)
        #expect(UIConfiguration.Padding.horizontal > 0)
        #expect(UIConfiguration.Padding.vertical > 0)
    }
    
    @Test("Frame configuration has valid dimensions")
    func frameConfigurationValues() {
        #expect(UIConfiguration.Frame.iconWidth > 0)
        #expect(UIConfiguration.Frame.topPadding > 0)
    }
    
    @Test("Exercise configuration has valid counts")
    func exerciseConfigurationValues() {
        #expect(UIConfiguration.Exercise.defaultItemCount > 0)
        #expect(UIConfiguration.Exercise.randomItemCount > 0)
        #expect(UIConfiguration.Exercise.defaultItemCount > UIConfiguration.Exercise.randomItemCount)
    }
}

// MARK: - Exercise Layout Config Tests
struct ExerciseLayoutConfigTests {
    
    @Test("Predefined layout configurations are valid")
    func predefinedLayoutConfigurations() {
        let configs = [
            ExerciseLayoutConfig.randomSeventhChords,
            ExerciseLayoutConfig.randomTriads,
            ExerciseLayoutConfig.twelveKeys,
            ExerciseLayoutConfig.default
        ]
        
        for config in configs {
            #expect(config.columnCount > 0)
            #expect(config.itemHeight > 0)
            #expect(config.spacing > 0)
        }
    }
    
    @Test("Random seventh chords layout configuration")
    func randomSeventhChordsLayout() {
        let config = ExerciseLayoutConfig.randomSeventhChords
        #expect(config.columnCount == UIConfiguration.Grid.defaultColumnCount)
        #expect(config.itemHeight == UIConfiguration.Grid.defaultItemHeight)
        #expect(config.spacing == UIConfiguration.Grid.defaultSpacing)
    }
    
    @Test("Random triads layout configuration")
    func randomTriadsLayout() {
        let config = ExerciseLayoutConfig.randomTriads
        #expect(config.columnCount == UIConfiguration.Grid.triadColumnCount)
        #expect(config.itemHeight == UIConfiguration.Grid.triadItemHeight)
        #expect(config.spacing == UIConfiguration.Grid.defaultSpacing)
    }
    
    @Test("Twelve keys layout configuration")
    func twelveKeysLayout() {
        let config = ExerciseLayoutConfig.twelveKeys
        #expect(config.columnCount == UIConfiguration.Grid.twelveKeysColumnCount)
        #expect(config.itemHeight == UIConfiguration.Grid.defaultItemHeight)
        #expect(config.spacing == UIConfiguration.Grid.defaultSpacing)
    }
    
    @Test("Layout configurations have logical differences")
    func layoutConfigurationDifferences() {
        // Triads should have more columns (smaller items)
        #expect(ExerciseLayoutConfig.randomTriads.columnCount > ExerciseLayoutConfig.randomSeventhChords.columnCount)
        
        // Triads should have smaller item height
        #expect(ExerciseLayoutConfig.randomTriads.itemHeight < ExerciseLayoutConfig.randomSeventhChords.itemHeight)
    }
}

// MARK: - Theme Configuration Tests  
struct ThemeConfigurationTests {
    
    @Test("Font size configuration has valid values")
    func fontSizeConfigurationValues() {
        #expect(ThemeConfiguration.FontSize.title > 0)
        #expect(ThemeConfiguration.FontSize.body > 0)
        #expect(ThemeConfiguration.FontSize.caption > 0)
        #expect(ThemeConfiguration.FontSize.small > 0)
        
        // Ensure logical ordering
        #expect(ThemeConfiguration.FontSize.small < ThemeConfiguration.FontSize.caption)
        #expect(ThemeConfiguration.FontSize.caption < ThemeConfiguration.FontSize.body)
        #expect(ThemeConfiguration.FontSize.body < ThemeConfiguration.FontSize.title)
    }
    
    @Test("Color configuration has valid names")
    func colorConfigurationNames() {
        #expect(!ThemeConfiguration.Colors.cardBackground.isEmpty)
        #expect(!ThemeConfiguration.Colors.primaryText.isEmpty)
        #expect(!ThemeConfiguration.Colors.secondaryText.isEmpty)
        #expect(!ThemeConfiguration.Colors.accent.isEmpty)
    }
}
