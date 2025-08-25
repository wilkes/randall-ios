import Foundation
import AVFoundation
import Combine

// MARK: - Metronome Service
/// Service for handling metronome functionality across exercises
@MainActor
class MetronomeService: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isPlaying: Bool = false
    @Published var tempo: Double = 120.0
    @Published var currentBeat: Int = 1
    @Published var beatsPerMeasure: Int = 4
    
    // MARK: - Private Properties
    private var audioEngine: AVAudioEngine?
    private var playerNode: AVAudioPlayerNode?
    private var timer: Timer?
    private let clickSoundFile = "metronome_click"
    
    // MARK: - Configuration
    static let tempoRange: ClosedRange<Double> = 40.0...300.0
    static let defaultTempo: Double = 120.0
    
    // MARK: - Initialization
    init() {
        setupAudio()
    }
    
    deinit {
        // Clean up synchronous resources
        timer?.invalidate()
        timer = nil
        audioEngine?.stop()
    }
    
    // MARK: - Public Methods
    
    /// Start the metronome
    func start() {
        guard !isPlaying else { return }
        
        isPlaying = true
        currentBeat = 1
        
        startTimer()
    }
    
    /// Stop the metronome
    func stop() {
        isPlaying = false
        currentBeat = 1
        
        stopTimer()
    }
    
    /// Toggle metronome play/stop
    func toggle() {
        if isPlaying {
            stop()
        } else {
            start()
        }
    }
    
    /// Set tempo with validation
    func setTempo(_ newTempo: Double) {
        let clampedTempo = min(max(newTempo, Self.tempoRange.lowerBound), Self.tempoRange.upperBound)
        tempo = clampedTempo
        
        if isPlaying {
            restartTimer()
        }
    }
    
    /// Set beats per measure
    func setBeatsPerMeasure(_ beats: Int) {
        beatsPerMeasure = max(1, min(beats, 12)) // Reasonable range
        currentBeat = min(currentBeat, beatsPerMeasure)
    }
    
    // MARK: - Private Methods
    
    private func setupAudio() {
        do {
            audioEngine = AVAudioEngine()
            playerNode = AVAudioPlayerNode()
            
            guard let audioEngine = audioEngine,
                  let playerNode = playerNode else { return }
            
            audioEngine.attach(playerNode)
            audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: nil)
            
            try audioEngine.start()
        } catch {
            print("Failed to setup audio engine: \(error)")
        }
    }
    
    private func startTimer() {
        stopTimer()
        
        let interval = 60.0 / tempo
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func restartTimer() {
        if isPlaying {
            startTimer()
        }
    }
    
    private func tick() {
        playClick()
        advanceBeat()
    }
    
    private func playClick() {
        // Use system sound for simplicity - in production would use custom audio file
        let soundID: SystemSoundID = currentBeat == 1 ? 1103 : 1104 // Different sound for downbeat
        AudioServicesPlaySystemSound(soundID)
    }
    
    private func advanceBeat() {
        currentBeat += 1
        if currentBeat > beatsPerMeasure {
            currentBeat = 1
        }
    }
}

// MARK: - Metronome Configuration
extension MetronomeService {
    
    /// Common tempo presets for different musical styles
    enum TempoPreset: CaseIterable {
        case ballad      // 60-80 BPM
        case moderate    // 100-120 BPM  
        case upbeat      // 130-150 BPM
        case fast        // 160-180 BPM
        
        var name: String {
            switch self {
            case .ballad: return "Ballad"
            case .moderate: return "Moderate"
            case .upbeat: return "Upbeat"
            case .fast: return "Fast"
            }
        }
        
        var tempo: Double {
            switch self {
            case .ballad: return 70
            case .moderate: return 110
            case .upbeat: return 140
            case .fast: return 170
            }
        }
        
        var range: ClosedRange<Double> {
            switch self {
            case .ballad: return 60...80
            case .moderate: return 100...120
            case .upbeat: return 130...150
            case .fast: return 160...180
            }
        }
    }
}
