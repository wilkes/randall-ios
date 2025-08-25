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

// MARK: - Animation Configuration Tests
struct AnimationConfigurationTests {
    
    @Test("Animation duration constants are reasonable")
    func animationDurationConstants() {
        // Test all duration constants are positive and reasonable
        #expect(UIConfiguration.Animation.defaultDuration > 0)
        #expect(UIConfiguration.Animation.defaultDuration < 2.0) // Not too long for UI
        
        #expect(UIConfiguration.Animation.quickDuration > 0)
        #expect(UIConfiguration.Animation.quickDuration < UIConfiguration.Animation.defaultDuration)
        
        #expect(UIConfiguration.Animation.slowDuration > 0)
        #expect(UIConfiguration.Animation.slowDuration > UIConfiguration.Animation.defaultDuration)
        #expect(UIConfiguration.Animation.slowDuration < 2.0) // Still reasonable for UI
    }
    
    @Test("Animation duration ordering is logical")
    func animationDurationOrdering() {
        // Quick < Default < Slow
        #expect(UIConfiguration.Animation.quickDuration < UIConfiguration.Animation.defaultDuration)
        #expect(UIConfiguration.Animation.defaultDuration < UIConfiguration.Animation.slowDuration)
    }
    
    @Test("Specific animation duration values")
    func specificAnimationDurationValues() {
        #expect(UIConfiguration.Animation.defaultDuration == 0.4)
        #expect(UIConfiguration.Animation.quickDuration == 0.1)
        #expect(UIConfiguration.Animation.slowDuration == 0.6)
    }
    
    @Test("Animation easing types are properly configured")
    func animationEasingTypes() {
        // These tests verify the animations are created correctly
        // We can't test the exact animation type, but we can ensure they're not nil
        // and have reasonable durations embedded
        let defaultEasing = UIConfiguration.Animation.defaultEasing
        let quickEasing = UIConfiguration.Animation.quickEasing
        let slowEasing = UIConfiguration.Animation.slowEasing
        let beatIndicator = UIConfiguration.Animation.beatIndicator
        
        // Verify animations exist (not nil)
        #expect(String(describing: defaultEasing).contains("easeInOut"))
        #expect(String(describing: quickEasing).contains("easeInOut"))
        #expect(String(describing: slowEasing).contains("easeInOut"))
        #expect(String(describing: beatIndicator).contains("easeInOut"))
    }
    
    @Test("Beat indicator animation matches quick animation")
    func beatIndicatorAnimation() {
        // Beat indicator should use quick duration for responsive feedback
        let beatIndicator = UIConfiguration.Animation.beatIndicator
        let quickEasing = UIConfiguration.Animation.quickEasing
        
        // Compare string representations to verify they're equivalent
        #expect(String(describing: beatIndicator) == String(describing: quickEasing))
    }
}

// MARK: - Animation Migration Tests
struct AnimationMigrationTests {
    
    @Test("Deprecated animation duration matches new centralized value")
    func deprecatedAnimationDurationCompatibility() {
        // Ensure backward compatibility during migration
        #expect(ExerciseConfiguration.animationDuration == UIConfiguration.Animation.defaultDuration)
    }
    
    @Test("Animation constants are used consistently")
    func animationConstantsConsistency() {
        // Verify centralized constants maintain expected relationships
        #expect(UIConfiguration.Animation.defaultDuration == 0.4)
        #expect(UIConfiguration.Animation.quickDuration == 0.1)
        #expect(UIConfiguration.Animation.slowDuration == 0.6)
        
        // Verify relationships
        #expect(UIConfiguration.Animation.quickDuration * 4 == UIConfiguration.Animation.defaultDuration)
        #expect(UIConfiguration.Animation.slowDuration == UIConfiguration.Animation.defaultDuration * 1.5)
    }
}
