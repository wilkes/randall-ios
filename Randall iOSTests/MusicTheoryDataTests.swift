import Testing
@testable import Randall_iOS

struct MusicTheoryDataTests {
    
    // MARK: - Data Validation Tests
    
    @Test("Keys array contains 12 chromatic notes")
    func keysValidation() {
        #expect(MusicTheoryData.keys.count == 12)
        
        let expectedKeys = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
        #expect(MusicTheoryData.keys == expectedKeys)
    }
    
    @Test("Modes array contains all 7 modes")
    func modesValidation() {
        #expect(MusicTheoryData.modes.count == 7)
        
        let expectedModes = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"]
        #expect(MusicTheoryData.modes == expectedModes)
    }
    
    @Test("Guitar strings array contains 6 strings")
    func guitarStringsValidation() {
        #expect(MusicTheoryData.guitarStrings.count == 6)
        
        let expectedStrings = ["E", "A", "D", "G", "B", "E"]
        #expect(MusicTheoryData.guitarStrings == expectedStrings)
    }
    
    @Test("String descriptions match guitar strings")
    func stringDescriptionsValidation() {
        #expect(MusicTheoryData.stringDescriptions.count == 6)
        
        let expectedDescriptions = ["E (6th)", "A (5th)", "D (4th)", "G (3rd)", "B (2nd)", "E (1st)"]
        #expect(MusicTheoryData.stringDescriptions == expectedDescriptions)
    }
    
    @Test("Seventh chords array contains valid chords")
    func seventhChordsValidation() {
        #expect(MusicTheoryData.seventhChords.count == 35)
        #expect(MusicTheoryData.seventhChords.contains("Cmaj7"))
        #expect(MusicTheoryData.seventhChords.contains("Dm7"))
        #expect(MusicTheoryData.seventhChords.contains("Bm7b5"))
    }
    
    @Test("Triads array contains valid chords")
    func triadsValidation() {
        #expect(MusicTheoryData.triads.count == 42)
        #expect(MusicTheoryData.triads.contains("C"))
        #expect(MusicTheoryData.triads.contains("Dm"))
        #expect(MusicTheoryData.triads.contains("Bdim"))
    }
    
    @Test("Krantz zones contain valid fret ranges")
    func krantzZonesValidation() {
        #expect(MusicTheoryData.krantzZones.count == 9)
        #expect(MusicTheoryData.krantzZones.contains("1 2 3 4"))
        #expect(MusicTheoryData.krantzZones.contains("9 10 11 12"))
    }
    
    @Test("Krantz formulas contain valid patterns")
    func krantzFormulasValidation() {
        #expect(MusicTheoryData.krantzFormulas.count == 5)
        #expect(MusicTheoryData.krantzFormulas.contains("1 2 3 4 5 6 7"))
        #expect(MusicTheoryData.krantzFormulas.contains("1 2 b3 3 4 b5 5 7"))
    }
    
    @Test("Fingering patterns contain valid combinations")
    func fingeringPatternsValidation() {
        #expect(MusicTheoryData.fingeringPatterns.count == 24)
        #expect(MusicTheoryData.fingeringPatterns.contains("1234"))
        #expect(MusicTheoryData.fingeringPatterns.contains("4321"))
        
        // Verify all patterns are 4 characters
        for pattern in MusicTheoryData.fingeringPatterns {
            #expect(pattern.count == 4)
        }
        
        // Verify all patterns contain only digits 1-4
        for pattern in MusicTheoryData.fingeringPatterns {
            for char in pattern {
                #expect(["1", "2", "3", "4"].contains(String(char)))
            }
        }
    }
    
    @Test("Fret range contains 1-12")
    func fretRangeValidation() {
        #expect(MusicTheoryData.fretRange.count == 12)
        #expect(MusicTheoryData.fretRange.first == 1)
        #expect(MusicTheoryData.fretRange.last == 12)
        #expect(MusicTheoryData.fretRange.contains(6))
    }
    
    @Test("Tempo range is reasonable")
    func tempoRangeValidation() {
        #expect(MusicTheoryData.tempoRange.lowerBound == 60)
        #expect(MusicTheoryData.tempoRange.upperBound == 200)
        #expect(MusicTheoryData.tempoRange.contains(120)) // Common tempo
    }
}

// MARK: - Exercise Configuration Tests
struct ExerciseConfigurationTests {
    
    @Test("Default configuration values are reasonable")
    func defaultConfigurationValues() {
        #expect(ExerciseConfiguration.defaultChordCount == 12)
        #expect(ExerciseConfiguration.defaultTriadCount == 12)
        #expect(UIConfiguration.Animation.defaultDuration == 0.4)
        #expect(ExerciseConfiguration.gridSpacing == 12)
        #expect(ExerciseConfiguration.cardCornerRadius == 12)
        #expect(ExerciseConfiguration.itemCornerRadius == 8)
    }
    
    @Test("Animation duration is positive")
    func animationDurationPositive() {
        #expect(UIConfiguration.Animation.defaultDuration > 0)
        #expect(UIConfiguration.Animation.defaultDuration < 1.0) // Reasonable for UI animations
    }
    
    @Test("Grid spacing is positive")
    func gridSpacingPositive() {
        #expect(ExerciseConfiguration.gridSpacing > 0)
        #expect(ExerciseConfiguration.gridSpacing < 50) // Reasonable for UI
    }
    
    @Test("Corner radius values are reasonable")
    func cornerRadiusReasonable() {
        #expect(ExerciseConfiguration.cardCornerRadius > 0)
        #expect(ExerciseConfiguration.itemCornerRadius > 0)
        #expect(ExerciseConfiguration.cardCornerRadius > ExerciseConfiguration.itemCornerRadius)
    }
}
