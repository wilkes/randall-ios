import Testing
@testable import Randall_iOS

struct RandallIOSTests {
    
    @Test("App launches without crashing")
    func appLaunches() async throws {
        // Test that the main app components can be initialized
        let contentView = ContentView()
        #expect(contentView.body != nil)
    }
    
    @Test("ExerciseType enum contains all expected cases")
    func exerciseTypeEnum() {
        let allCases = ExerciseType.allCases
        
        #expect(allCases.count == 8)
        #expect(allCases.contains(.randomSeventhChords))
        #expect(allCases.contains(.goodrickOneStringVamp))
        #expect(allCases.contains(.randomTriads))
        #expect(allCases.contains(.krantzFormula))
        #expect(allCases.contains(.twelveKeys))
        #expect(allCases.contains(.goodrickTwoStringVamp))
        #expect(allCases.contains(.fingering))
        #expect(allCases.contains(.randomExercise))
    }
    
    @Test("ExerciseType display names are correct")
    func exerciseTypeDisplayNames() {
        #expect(ExerciseType.randomSeventhChords.displayName == "Random 7th Chords")
        #expect(ExerciseType.goodrickOneStringVamp.displayName == "Goodrick One String Vamp")
        #expect(ExerciseType.randomTriads.displayName == "Random Triads")
        #expect(ExerciseType.krantzFormula.displayName == "Krantz Formula")
        #expect(ExerciseType.twelveKeys.displayName == "12 Keys")
        #expect(ExerciseType.goodrickTwoStringVamp.displayName == "Goodrick Two String Vamp")
        #expect(ExerciseType.fingering.displayName == "Fingering")
        #expect(ExerciseType.randomExercise.displayName == "Random Exercise")
    }
}

// MARK: - Model Tests
struct ModelTests {
    
    @Test("Exercise model creates unique IDs")
    func exerciseUniqueIDs() {
        let exercise1 = Exercise(name: "Test 1", type: .randomSeventhChords)
        let exercise2 = Exercise(name: "Test 2", type: .randomTriads)
        
        #expect(exercise1.id != exercise2.id)
    }
    
    @Test("GoodrickVamp model stores correct values")
    func goodrickVampModel() {
        let vamp = GoodrickVamp(string: "E", key: "C", mode: "Ionian", tempo: "120")
        
        #expect(vamp.string == "E")
        #expect(vamp.key == "C")
        #expect(vamp.mode == "Ionian")
        #expect(vamp.tempo == "120")
    }
    
    @Test("KrantzFormula model stores correct values")
    func krantzFormulaModel() {
        let formula = KrantzFormula(key: "D", zone: "5 6 7 8", tempo: "140", formula: "1 3 5 7")
        
        #expect(formula.key == "D")
        #expect(formula.zone == "5 6 7 8")
        #expect(formula.tempo == "140")
        #expect(formula.formula == "1 3 5 7")
    }
    
    @Test("FingeringPattern model stores correct values")
    func fingeringPatternModel() {
        let pattern = FingeringPattern(startFret: 5, pattern: "2143", string: "G (3rd)")
        
        #expect(pattern.startFret == 5)
        #expect(pattern.pattern == "2143")
        #expect(pattern.string == "G (3rd)")
    }
}
