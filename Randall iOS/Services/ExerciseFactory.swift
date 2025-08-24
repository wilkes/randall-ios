import SwiftUI

// MARK: - Exercise Factory
struct ExerciseFactory {
    
    /// Creates a view for the specified exercise type
    @ViewBuilder
    static func createView(for exerciseType: ExerciseType) -> some View {
        switch exerciseType {
        case .randomSeventhChords:
            RandomSeventhChordsView()
        case .goodrickOneStringVamp:
            GoodrickOneStringVampView()
        case .randomTriads:
            RandomTriadsView()
        case .krantzFormula:
            KrantzFormulaView()
        case .twelveKeys:
            TwelveKeysView()
        case .goodrickTwoStringVamp:
            GoodrickTwoStringVampView()
        case .fingering:
            FingeringView()
        case .randomExercise:
            RandomExerciseView()
        }
    }
    
    /// Exercise metadata for configuration and display
    static func getMetadata(for exerciseType: ExerciseType) -> ExerciseMetadata {
        let config = getExerciseConfiguration(for: exerciseType)
        return ExerciseMetadata(
            title: exerciseType.displayName,
            category: config.category,
            difficulty: config.difficulty,
            estimatedDuration: config.duration
        )
    }
    
    /// Get exercise configuration parameters
    private static func getExerciseConfiguration(for exerciseType: ExerciseType) -> ExerciseConfig {
        switch exerciseType {
        case .randomSeventhChords: return ExerciseConfig(category: .chords, difficulty: .beginner, duration: 5)
        case .goodrickOneStringVamp: return ExerciseConfig(category: .scales, difficulty: .intermediate, duration: 10)
        case .randomTriads: return ExerciseConfig(category: .chords, difficulty: .beginner, duration: 3)
        case .krantzFormula: return ExerciseConfig(category: .scales, difficulty: .advanced, duration: 15)
        case .twelveKeys: return ExerciseConfig(category: .theory, difficulty: .intermediate, duration: 8)
        case .goodrickTwoStringVamp: return ExerciseConfig(category: .scales, difficulty: .advanced, duration: 12)
        case .fingering: return ExerciseConfig(category: .technique, difficulty: .beginner, duration: 7)
        case .randomExercise: return ExerciseConfig(category: .mixed, difficulty: .intermediate, duration: 10)
        }
    }
}

// MARK: - Exercise Configuration
private struct ExerciseConfig {
    let category: ExerciseCategory
    let difficulty: ExerciseDifficulty
    let duration: Int
}

// MARK: - Exercise Metadata
struct ExerciseMetadata {
    let title: String
    let category: ExerciseCategory
    let difficulty: ExerciseDifficulty
    let estimatedDuration: Int // minutes
}

enum ExerciseCategory: String, CaseIterable {
    case chords = "Chords"
    case scales = "Scales"
    case theory = "Theory"
    case technique = "Technique"
    case mixed = "Mixed"
    
    var icon: String {
        switch self {
        case .chords: return "music.note.house"
        case .scales: return "waveform"
        case .theory: return "book"
        case .technique: return "hand.raised"
        case .mixed: return "shuffle"
        }
    }
}

enum ExerciseDifficulty: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var color: String {
        switch self {
        case .beginner: return "green"
        case .intermediate: return "orange"
        case .advanced: return "red"
        }
    }
}
