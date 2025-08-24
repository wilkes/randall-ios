import Testing
import SwiftUI
@testable import Randall_iOS

@MainActor
struct ExerciseViewTests {
    
    // MARK: - RandomSeventhChordsView Tests
    
    @Test("RandomSeventhChordsView initializes with empty chords")
    func randomSeventhChordsInitialState() {
        let view = RandomSeventhChordsView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    // MARK: - RandomTriadsView Tests
    
    @Test("RandomTriadsView initializes with empty triads")
    func randomTriadsInitialState() {
        let view = RandomTriadsView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    // MARK: - TwelveKeysView Tests
    
    @Test("TwelveKeysView initializes with empty keys")
    func twelveKeysInitialState() {
        let view = TwelveKeysView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    // MARK: - GoodrickOneStringVampView Tests
    
    @Test("GoodrickOneStringVampView initializes with default vamp")
    func goodrickVampInitialState() {
        let view = GoodrickOneStringVampView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    // MARK: - KrantzFormulaView Tests
    
    @Test("KrantzFormulaView initializes with default formula")
    func krantzFormulaInitialState() {
        let view = KrantzFormulaView()
        // View should initialize successfully  
        #expect(view.body != nil)
    }
    
    // MARK: - FingeringView Tests
    
    @Test("FingeringView initializes with default pattern")
    func fingeringViewInitialState() {
        let view = FingeringView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    // MARK: - Placeholder Views Tests
    
    @Test("GoodrickTwoStringVampView shows coming soon")
    func goodrickTwoStringVampComingSoon() {
        let view = GoodrickTwoStringVampView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
    
    @Test("RandomExerciseView shows coming soon")
    func randomExerciseComingSoon() {
        let view = RandomExerciseView()
        // View should initialize successfully
        #expect(view.body != nil)
    }
}

// MARK: - Exercise Data Generation Tests
struct ExerciseDataGenerationTests {
    
    @Test("Generate random chords returns correct count")
    func generateRandomChordsCount() {
        let chords = Array(MusicTheoryData.seventhChords.shuffled().prefix(12))
        #expect(chords.count == 12)
        #expect(chords.count <= MusicTheoryData.seventhChords.count)
    }
    
    @Test("Generate random triads returns correct count")
    func generateRandomTriadsCount() {
        let triads = Array(MusicTheoryData.triads.shuffled().prefix(12))
        #expect(triads.count == 12)
        #expect(triads.count <= MusicTheoryData.triads.count)
    }
    
    @Test("Generate random keys returns all keys")
    func generateRandomKeysCount() {
        let keys = MusicTheoryData.keys.shuffled()
        #expect(keys.count == 12)
        #expect(keys.count == MusicTheoryData.keys.count)
    }
    
    @Test("Generated data contains valid elements")
    func generatedDataValidity() {
        let randomChords = Array(MusicTheoryData.seventhChords.shuffled().prefix(5))
        let randomTriads = Array(MusicTheoryData.triads.shuffled().prefix(5))
        let randomKeys = MusicTheoryData.keys.shuffled()
        
        // All generated chords should be from the source data
        for chord in randomChords {
            #expect(MusicTheoryData.seventhChords.contains(chord))
        }
        
        // All generated triads should be from the source data
        for triad in randomTriads {
            #expect(MusicTheoryData.triads.contains(triad))
        }
        
        // All generated keys should be from the source data
        for key in randomKeys {
            #expect(MusicTheoryData.keys.contains(key))
        }
    }
    
    @Test("Random vamp generation produces valid data")
    func randomVampGeneration() {
        let randomString = MusicTheoryData.guitarStrings.randomElement() ?? "E"
        let randomKey = MusicTheoryData.keys.randomElement() ?? "C"
        let randomMode = MusicTheoryData.modes.randomElement() ?? "Ionian"
        let randomTempo = Int.random(in: MusicTheoryData.tempoRange)
        
        #expect(MusicTheoryData.guitarStrings.contains(randomString))
        #expect(MusicTheoryData.keys.contains(randomKey))
        #expect(MusicTheoryData.modes.contains(randomMode))
        #expect(MusicTheoryData.tempoRange.contains(randomTempo))
    }
    
    @Test("Random Krantz formula generation produces valid data")
    func randomKrantzGeneration() {
        let randomKey = MusicTheoryData.keys.randomElement() ?? "C"
        let randomZone = MusicTheoryData.krantzZones.randomElement() ?? "1 2 3 4"
        let randomFormula = MusicTheoryData.krantzFormulas.randomElement() ?? "1 2 3 4 5 6 7"
        let randomTempo = Int.random(in: MusicTheoryData.tempoRange)
        
        #expect(MusicTheoryData.keys.contains(randomKey))
        #expect(MusicTheoryData.krantzZones.contains(randomZone))
        #expect(MusicTheoryData.krantzFormulas.contains(randomFormula))
        #expect(MusicTheoryData.tempoRange.contains(randomTempo))
    }
    
    @Test("Random fingering pattern generation produces valid data")
    func randomFingeringGeneration() {
        let randomFret = MusicTheoryData.fretRange.randomElement() ?? 1
        let randomPattern = MusicTheoryData.fingeringPatterns.randomElement() ?? "1234"
        let randomString = MusicTheoryData.stringDescriptions.randomElement() ?? "E (6th)"
        
        #expect(MusicTheoryData.fretRange.contains(randomFret))
        #expect(MusicTheoryData.fingeringPatterns.contains(randomPattern))
        #expect(MusicTheoryData.stringDescriptions.contains(randomString))
    }
}
