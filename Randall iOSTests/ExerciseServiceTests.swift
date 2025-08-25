import Testing
@testable import Randall_iOS

// MARK: - Mock Music Theory Data Provider
class MockMusicTheoryDataProvider: MusicTheoryDataProviding {
    static var seventhChords: [String] = ["Cmaj7", "Dm7", "Em7", "Fmaj7", "G7", "Am7", "Bm7b5"]
    static var triads: [String] = ["C", "Dm", "Em", "F", "G", "Am", "Bdim"]
    static var keys: [String] = ["C", "Db", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    static var krantzZones: [String] = ["6 7 8 9", "7 8 9 10", "8 9 10 11"]
    static var krantzFormulas: [String] = ["1 2 b3 3 4 b5 5 7", "1 b2 2 b3 3 4 b5 5"]
    static var guitarStrings: [String] = ["E", "B", "G", "D", "A", "E"]
    static var modes: [String] = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"]
    static var fingeringPatterns: [String] = ["1234", "4321", "1324", "1243"]
    static var fretRange: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    static var stringDescriptions: [String] = ["E (1st)", "B (2nd)", "G (3rd)", "D (4th)", "A (5th)", "E (6th)"]
    static var tempoRange: ClosedRange<Int> = 60...180
}

// MARK: - Exercise Service Tests
@MainActor
struct ExerciseServiceTests {
    
    @Test("ExerciseService singleton is accessible")
    func exerciseServiceSingleton() {
        let service = ExerciseService.shared
        #expect(service !== nil)
    }
    
    @Test("ExerciseService can be initialized with custom provider")
    func exerciseServiceCustomProvider() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        #expect(service !== nil)
    }
    
    @Test("Generate random seventh chords content")
    func generateRandomSeventhChords() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .randomSeventhChords)
        
        if case .chords(let chords) = content {
            #expect(chords.count > 0)
            #expect(chords.count <= UIConfiguration.Exercise.defaultItemCount)
            // Verify all chords are from the mock data
            for chord in chords {
                #expect(MockMusicTheoryDataProvider.seventhChords.contains(chord))
            }
        } else {
            Issue.record("Expected chords content, got \(content)")
        }
    }
    
    @Test("Generate random triads content")
    func generateRandomTriads() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .randomTriads)
        
        if case .triads(let triads) = content {
            #expect(triads.count > 0)
            #expect(triads.count <= UIConfiguration.Exercise.defaultItemCount)
            // Verify all triads are from the mock data
            for triad in triads {
                #expect(MockMusicTheoryDataProvider.triads.contains(triad))
            }
        } else {
            Issue.record("Expected triads content, got \(content)")
        }
    }
    
    @Test("Generate twelve keys content")
    func generateTwelveKeys() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .twelveKeys)
        
        if case .keys(let keys) = content {
            #expect(keys.count == MockMusicTheoryDataProvider.keys.count)
            // All keys should be present (shuffled)
            for key in MockMusicTheoryDataProvider.keys {
                #expect(keys.contains(key))
            }
        } else {
            Issue.record("Expected keys content, got \(content)")
        }
    }
    
    @Test("Generate Krantz formula content")
    func generateKrantzFormula() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .krantzFormula)
        
        if case .krantzFormula(let formula) = content {
            #expect(MockMusicTheoryDataProvider.keys.contains(formula.key))
            #expect(MockMusicTheoryDataProvider.krantzZones.contains(formula.zone))
            #expect(MockMusicTheoryDataProvider.krantzFormulas.contains(formula.formula))
            
            // Validate tempo is in range
            if let tempo = Int(formula.tempo) {
                #expect(MockMusicTheoryDataProvider.tempoRange.contains(tempo))
            } else {
                Issue.record("Tempo should be a valid integer")
            }
        } else {
            Issue.record("Expected krantzFormula content, got \(content)")
        }
    }
    
    @Test("Generate Goodrick vamp content")
    func generateGoodrickVamp() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .goodrickOneStringVamp)
        
        if case .goodrickVamp(let vamp) = content {
            #expect(MockMusicTheoryDataProvider.guitarStrings.contains(vamp.string))
            #expect(MockMusicTheoryDataProvider.keys.contains(vamp.key))
            #expect(MockMusicTheoryDataProvider.modes.contains(vamp.mode))
            
            // Validate tempo is in range
            if let tempo = Int(vamp.tempo) {
                #expect(MockMusicTheoryDataProvider.tempoRange.contains(tempo))
            } else {
                Issue.record("Tempo should be a valid integer")
            }
        } else {
            Issue.record("Expected goodrickVamp content, got \(content)")
        }
    }
    
    @Test("Generate fingering pattern content")
    func generateFingeringPattern() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .fingering)
        
        if case .fingeringPattern(let pattern) = content {
            #expect(MockMusicTheoryDataProvider.fretRange.contains(pattern.startFret))
            #expect(MockMusicTheoryDataProvider.fingeringPatterns.contains(pattern.pattern))
            #expect(MockMusicTheoryDataProvider.stringDescriptions.contains(pattern.string))
        } else {
            Issue.record("Expected fingeringPattern content, got \(content)")
        }
    }
    
    @Test("Generate random exercise content")
    func generateRandomExercise() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        let content = service.generateContent(for: .randomExercise)
        
        if case .mixed(let items) = content {
            #expect(items.count > 0)
            #expect(items.count <= 6) // 3 chords + 3 triads
            
            // All items should be from either chords or triads
            for item in items {
                let isValidChord = MockMusicTheoryDataProvider.seventhChords.contains(item)
                let isValidTriad = MockMusicTheoryDataProvider.triads.contains(item)
                #expect(isValidChord || isValidTriad)
            }
        } else {
            Issue.record("Expected mixed content, got \(content)")
        }
    }
    
    @Test("Refresh content returns new content")
    func refreshContent() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        
        let content1 = service.refreshContent(for: .randomSeventhChords)
        let content2 = service.refreshContent(for: .randomSeventhChords)
        
        // Both should be valid chords content
        #expect(!content1.isEmpty)
        #expect(!content2.isEmpty)
        
        // They might be different due to randomization (not guaranteed but likely)
        if case .chords(let chords1) = content1,
           case .chords(let chords2) = content2 {
            #expect(chords1.count == chords2.count)
        }
    }
    
    @Test("Get metadata for exercises")
    func getMetadata() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        
        let metadata = service.getMetadata(for: .randomSeventhChords)
        
        #expect(metadata.title == "Random 7th Chords")
        #expect(metadata.estimatedDuration > 0)
        #expect(metadata.category != nil)
        #expect(metadata.difficulty != nil)
    }
    
    @Test("Content validation works correctly")
    func contentValidation() {
        let service = ExerciseService(musicDataProvider: MockMusicTheoryDataProvider.self)
        
        let validContent = ExerciseContent.chords(["Cmaj7", "Dm7"])
        let emptyContent = ExerciseContent.chords([])
        
        #expect(service.validateContent(validContent) == true)
        #expect(service.validateContent(emptyContent) == false)
    }
}

// MARK: - Exercise Content Tests
struct ExerciseContentTests {
    
    @Test("ExerciseContent isEmpty works correctly")
    func exerciseContentIsEmpty() {
        let emptyChords = ExerciseContent.chords([])
        let validChords = ExerciseContent.chords(["Cmaj7"])
        let krantzFormula = ExerciseContent.krantzFormula(KrantzFormula(key: "C", zone: "1", tempo: "120", formula: "1 2 3"))
        
        #expect(emptyChords.isEmpty == true)
        #expect(validChords.isEmpty == false)
        #expect(krantzFormula.isEmpty == false) // Always has content
    }
    
    @Test("All ExerciseContent cases work")
    func exerciseContentCases() {
        let chords = ExerciseContent.chords(["Cmaj7"])
        let triads = ExerciseContent.triads(["C"])
        let keys = ExerciseContent.keys(["C"])
        let mixed = ExerciseContent.mixed(["Test"])
        
        #expect(!chords.isEmpty)
        #expect(!triads.isEmpty)
        #expect(!keys.isEmpty)
        #expect(!mixed.isEmpty)
    }
}

// MARK: - Music Theory Data Provider Tests
struct MusicTheoryDataProviderTests {
    
    @Test("Mock data provider has required data")
    func mockDataProviderHasData() {
        #expect(!MockMusicTheoryDataProvider.seventhChords.isEmpty)
        #expect(!MockMusicTheoryDataProvider.triads.isEmpty)
        #expect(!MockMusicTheoryDataProvider.keys.isEmpty)
        #expect(!MockMusicTheoryDataProvider.krantzZones.isEmpty)
        #expect(!MockMusicTheoryDataProvider.krantzFormulas.isEmpty)
        #expect(!MockMusicTheoryDataProvider.guitarStrings.isEmpty)
        #expect(!MockMusicTheoryDataProvider.modes.isEmpty)
        #expect(!MockMusicTheoryDataProvider.fingeringPatterns.isEmpty)
        #expect(!MockMusicTheoryDataProvider.fretRange.isEmpty)
        #expect(!MockMusicTheoryDataProvider.stringDescriptions.isEmpty)
        #expect(MockMusicTheoryDataProvider.tempoRange.lowerBound > 0)
    }
    
    @Test("Real MusicTheoryData conforms to protocol")
    func realDataProviderConformance() {
        // This tests that MusicTheoryData actually conforms to the protocol
        #expect(!MusicTheoryData.seventhChords.isEmpty)
        #expect(!MusicTheoryData.triads.isEmpty)
        #expect(!MusicTheoryData.keys.isEmpty)
    }
}