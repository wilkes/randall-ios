import SwiftUI

// MARK: - Exercise Models
struct Exercise {
    let id = UUID()
    let name: String
    let type: ExerciseType
}

enum ExerciseType: CaseIterable {
    case randomSeventhChords
    case goodrickOneStringVamp
    case randomTriads
    case krantzFormula
    case twelveKeys
    case goodrickTwoStringVamp
    case fingering
    case randomExercise
    
    var displayName: String {
        switch self {
        case .randomSeventhChords: return "Random 7th Chords"
        case .goodrickOneStringVamp: return "Goodrick One String Vamp"
        case .randomTriads: return "Random Triads"
        case .krantzFormula: return "Krantz Formula"
        case .twelveKeys: return "12 Keys"
        case .goodrickTwoStringVamp: return "Goodrick Two String Vamp"
        case .fingering: return "Fingering"
        case .randomExercise: return "Random Exercise"
        }
    }
}

// MARK: - Music Theory Models
struct GoodrickVamp {
    let string: String
    let key: String
    let mode: String
    let tempo: String
}

struct KrantzFormula {
    let key: String
    let zone: String
    let tempo: String
    let formula: String
}

struct FingeringPattern {
    let startFret: Int
    let pattern: String
    let string: String
}
