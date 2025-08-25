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

// MARK: - Exercise Model Implementations

@MainActor
class RandomSeventhChordsExercise: ObservableObject, ExerciseProtocol {
    let id = UUID()
    let title = "Random 7th Chords"
    
    @Published private(set) var currentChords: [String] = []
    private let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol = ExerciseService.shared) {
        self.exerciseService = exerciseService
    }
    
    var isLoaded: Bool {
        !currentChords.isEmpty
    }
    
    var metadata: ExerciseMetadata {
        exerciseService.getMetadata(for: .randomSeventhChords)
    }
    
    func refresh() {
        let content = exerciseService.refreshContent(for: .randomSeventhChords)
        if case .chords(let chords) = content {
            currentChords = chords
        }
    }
}

@MainActor
class RandomTriadsExercise: ObservableObject, ExerciseProtocol {
    let id = UUID()
    let title = "Random Triads"
    
    @Published private(set) var currentTriads: [String] = []
    private let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol = ExerciseService.shared) {
        self.exerciseService = exerciseService
    }
    
    var isLoaded: Bool {
        !currentTriads.isEmpty
    }
    
    var metadata: ExerciseMetadata {
        exerciseService.getMetadata(for: .randomTriads)
    }
    
    func refresh() {
        let content = exerciseService.refreshContent(for: .randomTriads)
        if case .triads(let triads) = content {
            currentTriads = triads
        }
    }
}

@MainActor
class TwelveKeysExercise: ObservableObject, ExerciseProtocol {
    let id = UUID()
    let title = "12 Keys"
    
    @Published private(set) var currentKeys: [String] = []
    private let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol = ExerciseService.shared) {
        self.exerciseService = exerciseService
    }
    
    var isLoaded: Bool {
        !currentKeys.isEmpty
    }
    
    var metadata: ExerciseMetadata {
        exerciseService.getMetadata(for: .twelveKeys)
    }
    
    func refresh() {
        let content = exerciseService.refreshContent(for: .twelveKeys)
        if case .keys(let keys) = content {
            currentKeys = keys
        }
    }
}

@MainActor
class KrantzFormulaExercise: ObservableObject, ExerciseProtocol {
    let id = UUID()
    let title = "Krantz Formula"
    
    @Published private(set) var currentFormula = KrantzFormula(
        key: "C", 
        zone: "6 7 8 9", 
        tempo: "74", 
        formula: "1 2 b3 3 4 b5 5 7"
    )
    private let exerciseService: ExerciseServiceProtocol
    
    init(exerciseService: ExerciseServiceProtocol = ExerciseService.shared) {
        self.exerciseService = exerciseService
    }
    
    var isLoaded: Bool {
        true // Always has default value
    }
    
    var metadata: ExerciseMetadata {
        exerciseService.getMetadata(for: .krantzFormula)
    }
    
    func refresh() {
        let content = exerciseService.refreshContent(for: .krantzFormula)
        if case .krantzFormula(let formula) = content {
            currentFormula = formula
        }
    }
}