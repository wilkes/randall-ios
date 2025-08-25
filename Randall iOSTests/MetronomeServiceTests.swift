import Testing
@testable import Randall_iOS

// MARK: - Metronome Service Tests
@MainActor
struct MetronomeServiceTests {
    
    @Test("Metronome initializes with default values")
    func metronomeInitialization() {
        let metronome = MetronomeService()
        
        #expect(metronome.isPlaying == false)
        #expect(metronome.tempo == MetronomeService.defaultTempo)
        #expect(metronome.currentBeat == 1)
        #expect(metronome.beatsPerMeasure == 4)
    }
    
    @Test("Metronome tempo validation enforces range limits")
    func metronomeTempoValidation() {
        let metronome = MetronomeService()
        
        // Test lower bound
        metronome.setTempo(-10)
        #expect(metronome.tempo == MetronomeService.tempoRange.lowerBound)
        
        // Test upper bound
        metronome.setTempo(500)
        #expect(metronome.tempo == MetronomeService.tempoRange.upperBound)
        
        // Test valid value
        metronome.setTempo(120)
        #expect(metronome.tempo == 120)
    }
    
    @Test("Metronome beats per measure validation")
    func metronomeBeatsPerMeasureValidation() {
        let metronome = MetronomeService()
        
        // Test lower bound
        metronome.setBeatsPerMeasure(0)
        #expect(metronome.beatsPerMeasure == 1)
        
        // Test upper bound
        metronome.setBeatsPerMeasure(20)
        #expect(metronome.beatsPerMeasure == 12)
        
        // Test valid values
        metronome.setBeatsPerMeasure(3)
        #expect(metronome.beatsPerMeasure == 3)
        
        metronome.setBeatsPerMeasure(7)
        #expect(metronome.beatsPerMeasure == 7)
    }
    
    @Test("Metronome start/stop functionality")
    func metronomeStartStop() {
        let metronome = MetronomeService()
        
        // Initially stopped
        #expect(metronome.isPlaying == false)
        #expect(metronome.currentBeat == 1)
        
        // Start metronome
        metronome.start()
        #expect(metronome.isPlaying == true)
        #expect(metronome.currentBeat == 1) // Reset to 1 on start
        
        // Stop metronome
        metronome.stop()
        #expect(metronome.isPlaying == false)
        #expect(metronome.currentBeat == 1) // Reset to 1 on stop
    }
    
    @Test("Metronome toggle functionality")
    func metronomeToggle() {
        let metronome = MetronomeService()
        
        // Initially stopped
        #expect(metronome.isPlaying == false)
        
        // Toggle to start
        metronome.toggle()
        #expect(metronome.isPlaying == true)
        
        // Toggle to stop
        metronome.toggle()
        #expect(metronome.isPlaying == false)
    }
    
    @Test("Multiple start calls don't affect state")
    func multipleStartCalls() {
        let metronome = MetronomeService()
        
        metronome.start()
        let firstState = metronome.isPlaying
        
        metronome.start() // Should be ignored
        #expect(metronome.isPlaying == firstState)
    }
    
    @Test("Tempo constants are within valid range")
    func tempoConstants() {
        #expect(MetronomeService.tempoRange.lowerBound > 0)
        #expect(MetronomeService.tempoRange.upperBound > MetronomeService.tempoRange.lowerBound)
        #expect(MetronomeService.defaultTempo >= MetronomeService.tempoRange.lowerBound)
        #expect(MetronomeService.defaultTempo <= MetronomeService.tempoRange.upperBound)
    }
}

// MARK: - Tempo Preset Tests
struct TempoPresetTests {
    
    @Test("All tempo presets have valid values")
    func tempoPresetValues() {
        for preset in MetronomeService.TempoPreset.allCases {
            #expect(preset.tempo > 0)
            #expect(preset.tempo >= MetronomeService.tempoRange.lowerBound)
            #expect(preset.tempo <= MetronomeService.tempoRange.upperBound)
            #expect(!preset.name.isEmpty)
        }
    }
    
    @Test("Tempo preset ranges are logical")
    func tempoPresetRanges() {
        for preset in MetronomeService.TempoPreset.allCases {
            #expect(preset.range.lowerBound < preset.range.upperBound)
            #expect(preset.range.contains(preset.tempo))
        }
    }
    
    @Test("Tempo presets are ordered by speed")
    func tempoPresetOrdering() {
        let presets = MetronomeService.TempoPreset.allCases
        
        #expect(presets[0] == .ballad)
        #expect(presets[1] == .moderate)
        #expect(presets[2] == .upbeat)
        #expect(presets[3] == .fast)
        
        // Ensure increasing tempo order
        for i in 0..<presets.count - 1 {
            #expect(presets[i].tempo < presets[i + 1].tempo)
        }
    }
    
    @Test("Specific tempo preset values")
    func specificTempoPresetValues() {
        #expect(MetronomeService.TempoPreset.ballad.tempo == 70)
        #expect(MetronomeService.TempoPreset.moderate.tempo == 110)
        #expect(MetronomeService.TempoPreset.upbeat.tempo == 140)
        #expect(MetronomeService.TempoPreset.fast.tempo == 170)
    }
    
    @Test("Tempo preset names are user-friendly")
    func tempoPresetNames() {
        #expect(MetronomeService.TempoPreset.ballad.name == "Ballad")
        #expect(MetronomeService.TempoPreset.moderate.name == "Moderate")  
        #expect(MetronomeService.TempoPreset.upbeat.name == "Upbeat")
        #expect(MetronomeService.TempoPreset.fast.name == "Fast")
    }
    
    @Test("Tempo preset ranges don't overlap")
    func tempoPresetRangesSeparate() {
        let presets = MetronomeService.TempoPreset.allCases
        
        for i in 0..<presets.count - 1 {
            let currentRange = presets[i].range
            let nextRange = presets[i + 1].range
            
            // Current range upper bound should be less than next range lower bound
            #expect(currentRange.upperBound < nextRange.lowerBound)
        }
    }
}
