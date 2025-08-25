import Foundation
import SwiftUI

// MARK: - Exercise Service Protocol
protocol ExerciseServiceProtocol {
    /// Generates random content for the specified exercise type
    func generateContent(for exerciseType: ExerciseType) -> ExerciseContent
    
    /// Refreshes and returns new content for the exercise
    func refreshContent(for exerciseType: ExerciseType) -> ExerciseContent
    
    /// Gets metadata for the exercise
    func getMetadata(for exerciseType: ExerciseType) -> ExerciseMetadata
    
    /// Validates if the exercise has sufficient data
    func validateContent(_ content: ExerciseContent) -> Bool
}

// MARK: - Exercise Content Model
enum ExerciseContent {
    case chords([String])
    case triads([String])
    case keys([String])
    case krantzFormula(KrantzFormula)
    case goodrickVamp(GoodrickVamp)
    case fingeringPattern(FingeringPattern)
    case mixed([String]) // For random exercise or fallback
    
    var isEmpty: Bool {
        switch self {
        case .chords(let items), .triads(let items), .keys(let items), .mixed(let items):
            return items.isEmpty
        case .krantzFormula(_), .goodrickVamp(_), .fingeringPattern(_):
            return false // These always have content
        }
    }
}

// MARK: - Exercise Service Implementation
class ExerciseService: ExerciseServiceProtocol {
    
    // MARK: - Singleton
    static let shared = ExerciseService()
    
    // MARK: - Private Properties  
    private let musicDataProvider: MusicTheoryDataProviding.Type
    
    // MARK: - Initialization
    init(musicDataProvider: MusicTheoryDataProviding.Type = MusicTheoryData.self) {
        self.musicDataProvider = musicDataProvider
    }
    
    // MARK: - Public Methods
    
    func generateContent(for exerciseType: ExerciseType) -> ExerciseContent {
        switch exerciseType {
        case .randomSeventhChords:
            return generateRandomSeventhChords()
        case .randomTriads:
            return generateRandomTriads()
        case .twelveKeys:
            return generateTwelveKeys()
        case .krantzFormula:
            return generateKrantzFormula()
        case .goodrickOneStringVamp:
            return generateGoodrickVamp()
        case .fingering:
            return generateFingeringPattern()
        case .goodrickTwoStringVamp:
            return generateGoodrickVamp() // Reuse same logic for now
        case .randomExercise:
            return generateRandomExercise()
        }
    }
    
    func refreshContent(for exerciseType: ExerciseType) -> ExerciseContent {
        return generateContent(for: exerciseType) // Same as generate for now
    }
    
    func getMetadata(for exerciseType: ExerciseType) -> ExerciseMetadata {
        return ExerciseFactory.getMetadata(for: exerciseType)
    }
    
    func validateContent(_ content: ExerciseContent) -> Bool {
        return !content.isEmpty
    }
}

// MARK: - Private Exercise Generation Methods
private extension ExerciseService {
    
    func generateRandomSeventhChords() -> ExerciseContent {
        let count = UIConfiguration.Exercise.defaultItemCount
        let chords = Array(musicDataProvider.seventhChords.shuffled().prefix(count))
        return .chords(chords)
    }
    
    func generateRandomTriads() -> ExerciseContent {
        let count = UIConfiguration.Exercise.defaultItemCount
        let triads = Array(musicDataProvider.triads.shuffled().prefix(count))
        return .triads(triads)
    }
    
    func generateTwelveKeys() -> ExerciseContent {
        let keys = musicDataProvider.keys.shuffled()
        return .keys(keys)
    }
    
    func generateKrantzFormula() -> ExerciseContent {
        let formula = KrantzFormula(
            key: musicDataProvider.keys.randomElement() ?? "C",
            zone: musicDataProvider.krantzZones.randomElement() ?? "6 7 8 9",
            tempo: String(Int.random(in: musicDataProvider.tempoRange)),
            formula: musicDataProvider.krantzFormulas.randomElement() ?? "1 2 b3 3 4 b5 5 7"
        )
        return .krantzFormula(formula)
    }
    
    func generateGoodrickVamp() -> ExerciseContent {
        let vamp = GoodrickVamp(
            string: musicDataProvider.guitarStrings.randomElement() ?? "B",
            key: musicDataProvider.keys.randomElement() ?? "Db", 
            mode: musicDataProvider.modes.randomElement() ?? "Locrian",
            tempo: String(Int.random(in: musicDataProvider.tempoRange))
        )
        return .goodrickVamp(vamp)
    }
    
    func generateFingeringPattern() -> ExerciseContent {
        let pattern = FingeringPattern(
            startFret: musicDataProvider.fretRange.randomElement() ?? 1,
            pattern: musicDataProvider.fingeringPatterns.randomElement() ?? "1234",
            string: musicDataProvider.stringDescriptions.randomElement() ?? "E (6th)"
        )
        return .fingeringPattern(pattern)
    }
    
    func generateRandomExercise() -> ExerciseContent {
        // For now, generate a random selection of chords and triads mixed
        let chords = Array(musicDataProvider.seventhChords.shuffled().prefix(3))
        let triads = Array(musicDataProvider.triads.shuffled().prefix(3))
        let mixed = (chords + triads).shuffled()
        return .mixed(mixed)
    }
}

// MARK: - Music Theory Data Providing Protocol
protocol MusicTheoryDataProviding {
    static var seventhChords: [String] { get }
    static var triads: [String] { get }
    static var keys: [String] { get }
    static var krantzZones: [String] { get }
    static var krantzFormulas: [String] { get }
    static var guitarStrings: [String] { get }
    static var modes: [String] { get }
    static var fingeringPatterns: [String] { get }
    static var fretRange: [Int] { get }
    static var stringDescriptions: [String] { get }
    static var tempoRange: ClosedRange<Int> { get }
}

// MARK: - MusicTheoryData Conformance
extension MusicTheoryData: MusicTheoryDataProviding {
    // Conformance is already implemented via existing static properties
}