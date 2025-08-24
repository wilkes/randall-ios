# Randall iOS

A comprehensive music theory practice app for iOS, designed to help musicians develop their skills through interactive exercises.

## Overview

Randall iOS provides a suite of music theory exercises including chord recognition, scale practice, fingering patterns, and more. Built with SwiftUI and featuring a clean, modern interface optimized for practice sessions.

## Features

### 🎵 Exercise Types
- **Random 7th Chords** - Practice identifying and playing seventh chord progressions
- **Random Triads** - Master basic triad shapes and progressions  
- **Goodrick One String Vamp** - Single-string scale practice with modes
- **Krantz Formula** - Advanced scale formula exercises
- **12 Keys** - Practice scales and patterns in all 12 keys
- **Fingering Patterns** - Develop technical proficiency with finger exercises
- **Random Exercise** - Mixed practice sessions

### 🎨 Modern Architecture
- **SwiftUI** - Native iOS interface with smooth animations
- **Generic Exercise Container** - Reusable components for consistent UX
- **Centralized Configuration** - Maintainable UI constants and theming
- **Factory Pattern** - Extensible exercise creation system

### 🧪 Quality Assurance
- **51 comprehensive tests** covering all major components
- **SwiftLint compliance** with zero violations
- **CI/CD pipeline** with automated testing and builds
- **100% Swift** - No Objective-C dependencies

## Architecture

### Core Components

#### Exercise System
```swift
ExerciseFactory.createView(for: exerciseType) // Centralized exercise creation
ExerciseLayoutConfig.randomTriads            // Pre-configured layouts  
UIConfiguration.Spacing.large                // Semantic UI constants
```

#### Configuration System
- **UIConfiguration** - Centralized spacing, sizing, and layout constants
- **ExerciseLayoutConfig** - Exercise-specific presets (columns, heights, spacing)
- **ThemeConfiguration** - Font sizes and color system for future theming

#### Shared Components
- **GenericExerciseContainer** - Base container for all exercises
- **SimpleGridExercise** - Grid-based exercise layout
- **ParameterExercise** - Parameter-card exercise layout

### Music Theory Data
- **12 chromatic keys** with enharmonic equivalents
- **7 musical modes** (Ionian, Dorian, Phrygian, etc.)
- **35 seventh chord types** including extensions and alterations
- **42 triad variations** covering major, minor, diminished, augmented
- **24 fingering patterns** for technical development

## Getting Started

### Prerequisites
- iOS 18.0 or later
- Xcode 16.2 or later
- Swift 5.9 or later

### Building
```bash
# Clone the repository
git clone https://github.com/wilkes/randall-ios.git
cd randall-ios/Randall\ iOS

# Open in Xcode
open Randall\ iOS.xcodeproj

# Or build from command line
xcodebuild -project "Randall iOS.xcodeproj" -scheme "Randall iOS" build
```

### Running Tests
```bash
# Run all tests
xcodebuild test -project "Randall iOS.xcodeproj" -scheme "Randall iOS"

# Run SwiftLint
swiftlint lint
```

## Development

### Project Structure
```
Randall iOS/
├── Configuration/          # Centralized UI configuration
│   └── UIConfiguration.swift
├── Models/                 # Data models and exercise definitions
│   └── ExerciseModels.swift
├── Services/               # Business logic and data services
│   ├── ExerciseFactory.swift
│   └── MusicTheoryData.swift  
├── Views/                  # SwiftUI views and components
│   ├── Components/         # Reusable UI components
│   └── ExerciseViews/      # Individual exercise implementations
└── Tests/                  # Comprehensive test suite
```

### Adding New Exercises

1. **Define Exercise Type**
```swift
// Add to ExerciseModels.swift
enum ExerciseType: CaseIterable {
    case newExercise
}
```

2. **Create View**
```swift
// Create NewExerciseView.swift
struct NewExerciseView: View {
    var body: some View {
        GenericExerciseContainer(title: "New Exercise", onRefresh: refresh) {
            // Exercise content
        }
    }
}
```

3. **Register in Factory**
```swift
// Add to ExerciseFactory.swift
case .newExercise: NewExerciseView()
```

4. **Configure Layout** (optional)
```swift
// Add to UIConfiguration.swift  
static let newExercise = ExerciseLayoutConfig(
    columnCount: 3, itemHeight: 60, spacing: 12
)
```

### Code Style
- **SwiftLint** enforced with zero violations
- **Semantic naming** for all UI constants
- **Generic components** over specialized implementations
- **Comprehensive testing** for all new features

## Testing

### Test Categories
- **Unit Tests** - Core logic and data validation (45 tests)
- **UI Tests** - Interface behavior and navigation (6 tests) 
- **Integration Tests** - Exercise generation and display

### Coverage Areas
- ✅ Exercise data generation and validation
- ✅ UI configuration and layout presets
- ✅ Music theory data integrity  
- ✅ Component behavior and state management
- ✅ Factory pattern and exercise creation
- ✅ App launch and navigation flows

## CI/CD

The project includes GitHub Actions workflows for:
- **Automated testing** on pull requests
- **SwiftLint validation** for code quality
- **Build verification** across different configurations
- **Release archiving** for distribution

## Contributing

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Write tests** for new functionality
4. **Ensure** SwiftLint compliance (`swiftlint lint`)
5. **Commit** changes (`git commit -m 'Add amazing feature'`)
6. **Push** to branch (`git push origin feature/amazing-feature`)
7. **Open** a Pull Request

### Development Guidelines
- Follow existing architectural patterns
- Use centralized configuration for UI values  
- Write comprehensive tests for new features
- Maintain SwiftLint compliance
- Document complex music theory concepts

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- **Mick Goodrick** - Inspiration for one-string vamp exercises
- **Wayne Krantz** - Formula-based practice methodology
- **Jazz pedagogy community** - Exercise concepts and approaches

## Music Theory Resources

For musicians new to the concepts in this app:

- **Seventh Chords** - Extensions of triads with added seventh intervals
- **Modal Practice** - Scales based on different starting points of major scale
- **Formula Approach** - Interval-based method for learning scales and chords
- **12-Key Practice** - Ensuring proficiency in all chromatic keys

---

**Randall iOS** - Elevate your musical practice with structured, interactive exercises.