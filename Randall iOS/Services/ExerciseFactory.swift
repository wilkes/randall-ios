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
        switch exerciseType {
        case .randomSeventhChords:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .chords,
                difficulty: .beginner,
                estimatedDuration: 5
            )
        case .goodrickOneStringVamp:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .scales,
                difficulty: .intermediate,
                estimatedDuration: 10
            )
        case .randomTriads:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .chords,
                difficulty: .beginner,
                estimatedDuration: 3
            )
        case .krantzFormula:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .scales,
                difficulty: .advanced,
                estimatedDuration: 15
            )
        case .twelveKeys:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .theory,
                difficulty: .intermediate,
                estimatedDuration: 8
            )
        case .goodrickTwoStringVamp:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .scales,
                difficulty: .advanced,
                estimatedDuration: 12
            )
        case .fingering:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .technique,
                difficulty: .beginner,
                estimatedDuration: 7
            )
        case .randomExercise:
            return ExerciseMetadata(
                title: exerciseType.displayName,
                category: .mixed,
                difficulty: .intermediate,
                estimatedDuration: 10
            )
        }
    }
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