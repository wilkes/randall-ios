import Foundation
import SwiftUI

// MARK: - Centralized Music Theory Data
struct MusicTheoryData {
    
    // MARK: - Keys and Scales
    static let keys = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
    
    static let modes = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"]
    
    // MARK: - Guitar Strings
    static let guitarStrings = ["E", "A", "D", "G", "B", "E"]
    static let stringDescriptions = ["E (6th)", "A (5th)", "D (4th)", "G (3rd)", "B (2nd)", "E (1st)"]
    
    // MARK: - Seventh Chords
    static let seventhChords = [
        "Cmaj7", "Dm7", "Em7", "Fmaj7", "G7", "Am7", "Bm7b5",
        "Dbmaj7", "Ebm7", "Fm7", "Gbmaj7", "Ab7", "Bbm7", "Cm7b5",
        "Dmaj7", "Em7", "F#m7", "Gmaj7", "A7", "Bm7", "C#m7b5",
        "Ebmaj7", "Fm7", "Gm7", "Abmaj7", "Bb7", "Cm7", "Dm7b5",
        "Emaj7", "F#m7", "G#m7", "Amaj7", "B7", "C#m7", "D#m7b5"
    ]
    
    // MARK: - Triads
    static let triads = [
        "C", "Dm", "Em", "F", "G", "Am", "Bdim",
        "Db", "Ebm", "Fm", "Gb", "Ab", "Bbm", "Cdim",
        "D", "Em", "F#m", "G", "A", "Bm", "C#dim",
        "Eb", "Fm", "Gm", "Ab", "Bb", "Cm", "Ddim",
        "E", "F#m", "G#m", "A", "B", "C#m", "D#dim",
        "F", "Gm", "Am", "Bb", "C", "Dm", "Edim"
    ]
    
    // MARK: - Krantz Formula Data
    static let krantzZones = [
        "1 2 3 4", "2 3 4 5", "3 4 5 6", "4 5 6 7", 
        "5 6 7 8", "6 7 8 9", "7 8 9 10", "8 9 10 11", "9 10 11 12"
    ]
    
    static let krantzFormulas = [
        "1 2 3 4 5 6 7",
        "1 2 b3 3 4 b5 5 7",
        "1 b2 2 b3 4 b5 6 b7",
        "1 3 5 7 9 11 13",
        "1 2 4 5 7 9 11"
    ]
    
    // MARK: - Fingering Patterns
    static let fingeringPatterns = [
        "1234", "1243", "1324", "1342", "1423", "1432",
        "2134", "2143", "2314", "2341", "2413", "2431",
        "3124", "3142", "3214", "3241", "3412", "3421",
        "4123", "4132", "4213", "4231", "4312", "4321"
    ]
    
    static let fretRange = Array(1...12)
    
    // MARK: - Tempo Range
    static let tempoRange = 60...200
}

// MARK: - Exercise Configuration (Deprecated - Use UIConfiguration instead)
struct ExerciseConfiguration {
    static let defaultChordCount = UIConfiguration.Exercise.defaultItemCount
    static let defaultTriadCount = UIConfiguration.Exercise.defaultItemCount
    @available(*, deprecated, message: "Use UIConfiguration.Animation.defaultDuration instead")
    static let animationDuration = UIConfiguration.Animation.defaultDuration
    static let gridSpacing: CGFloat = UIConfiguration.Grid.defaultSpacing
    static let cardCornerRadius: CGFloat = UIConfiguration.CornerRadius.large
    static let itemCornerRadius: CGFloat = UIConfiguration.CornerRadius.small
}
