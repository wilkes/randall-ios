import SwiftUI

// MARK: - Random 7th Chords View
struct RandomSeventhChordsView: View {
    @State private var currentChords: [String] = []
    
    let seventhChords = [
        "Cmaj7", "Dm7", "Em7", "Fmaj7", "G7", "Am7", "Bm7b5",
        "Dbmaj7", "Ebm7", "Fm7", "Gbmaj7", "Ab7", "Bbm7", "Cm7b5",
        "Dmaj7", "Em7", "F#m7", "Gmaj7", "A7", "Bm7", "C#m7b5",
        "Ebmaj7", "Fm7", "Gm7", "Abmaj7", "Bb7", "Cm7", "Dm7b5",
        "Emaj7", "F#m7", "G#m7", "Amaj7", "B7", "C#m7", "D#m7b5"
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack(spacing: 12) {
                    HStack {
                        Text("Random 7th Chords")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomChords) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Chord Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ForEach(currentChords.indices, id: \.self) { index in
                        Text(currentChords[index])
                            .font(.title3.weight(.medium))
                            .foregroundColor(.primary)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            if currentChords.isEmpty {
                generateRandomChords()
            }
        }
    }
    
    private func generateRandomChords() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentChords = Array(seventhChords.shuffled().prefix(12))
        }
    }
}

// MARK: - Goodrick One String Vamp View
struct GoodrickOneStringVampView: View {
    @State private var currentVamp = GoodrickVamp(string: "B", key: "Db", mode: "Locrian", tempo: "123")
    
    let strings = ["E", "A", "D", "G", "B", "E"]
    let keys = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
    let modes = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack {
                    HStack {
                        Text("Goodrick One String Vamp")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomVamp) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Parameter Cards
                VStack(spacing: 16) {
                    ParameterCard(title: "String", value: currentVamp.string, icon: "guitars")
                    ParameterCard(title: "Key", value: currentVamp.key, icon: "music.note")
                    ParameterCard(title: "Mode", value: currentVamp.mode, icon: "waveform")
                    ParameterCard(title: "Tempo", value: currentVamp.tempo, icon: "metronome")
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            generateRandomVamp()
        }
    }
    
    private func generateRandomVamp() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentVamp = GoodrickVamp(
                string: strings.randomElement() ?? "B",
                key: keys.randomElement() ?? "Db",
                mode: modes.randomElement() ?? "Locrian",
                tempo: String(Int.random(in: 60...200))
            )
        }
    }
}

// MARK: - Parameter Card
struct ParameterCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.accentColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.title3.weight(.medium))
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Random Triads View
struct RandomTriadsView: View {
    @State private var currentTriads: [String] = []
    
    let triads = [
        "C", "Dm", "Em", "F", "G", "Am", "Bdim",
        "Db", "Ebm", "Fm", "Gb", "Ab", "Bbm", "Cdim",
        "D", "Em", "F#m", "G", "A", "Bm", "C#dim",
        "Eb", "Fm", "Gm", "Ab", "Bb", "Cm", "Ddim",
        "E", "F#m", "G#m", "A", "B", "C#m", "D#dim",
        "F", "Gm", "Am", "Bb", "C", "Dm", "Edim"
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack {
                    HStack {
                        Text("Random Triads")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomTriads) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Triad Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ForEach(currentTriads.indices, id: \.self) { index in
                        Text(currentTriads[index])
                            .font(.title3.weight(.medium))
                            .foregroundColor(.primary)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            if currentTriads.isEmpty {
                generateRandomTriads()
            }
        }
    }
    
    private func generateRandomTriads() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentTriads = Array(triads.shuffled().prefix(12))
        }
    }
}

// MARK: - Krantz Formula View
struct KrantzFormulaView: View {
    @State private var currentFormula = KrantzFormula(key: "C", zone: "6 7 8 9", tempo: "74", formula: "1 2 b3 3 4 b5 5 7")
    
    let keys = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
    let zones = ["1 2 3 4", "2 3 4 5", "3 4 5 6", "4 5 6 7", "5 6 7 8", "6 7 8 9", "7 8 9 10", "8 9 10 11", "9 10 11 12"]
    let formulas = [
        "1 2 3 4 5 6 7",
        "1 2 b3 3 4 b5 5 7",
        "1 b2 2 b3 4 b5 6 b7",
        "1 3 5 7 9 11 13",
        "1 2 4 5 7 9 11"
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack {
                    HStack {
                        Text("Krantz Formula")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomFormula) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Parameter Cards
                VStack(spacing: 16) {
                    ParameterCard(title: "Key", value: currentFormula.key, icon: "music.note")
                    ParameterCard(title: "Zone", value: currentFormula.zone, icon: "rectangle.grid.2x2")
                    ParameterCard(title: "Tempo", value: currentFormula.tempo, icon: "metronome")
                    
                    HStack(spacing: 16) {
                        Image(systemName: "function")
                            .font(.title3)
                            .foregroundColor(.accentColor)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Formula")
                                .font(.caption.weight(.medium))
                                .foregroundColor(.secondary)
                            Text(currentFormula.formula)
                                .font(.body.weight(.medium))
                                .foregroundColor(.primary)
                                .lineLimit(nil)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            generateRandomFormula()
        }
    }
    
    private func generateRandomFormula() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentFormula = KrantzFormula(
                key: keys.randomElement() ?? "C",
                zone: zones.randomElement() ?? "6 7 8 9",
                tempo: String(Int.random(in: 60...200)),
                formula: formulas.randomElement() ?? "1 2 b3 3 4 b5 5 7"
            )
        }
    }
}

// MARK: - 12 Keys View
struct TwelveKeysView: View {
    @State private var currentKeys: [String] = []
    
    let keys = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack {
                    HStack {
                        Text("12 Keys")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomKeys) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Key Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ForEach(currentKeys.indices, id: \.self) { index in
                        Text(currentKeys[index])
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            if currentKeys.isEmpty {
                generateRandomKeys()
            }
        }
    }
    
    private func generateRandomKeys() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentKeys = keys.shuffled()
        }
    }
}

// MARK: - Placeholder Views
struct GoodrickTwoStringVampView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "guitars.fill")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("Goodrick Two String Vamp")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text("Coming Soon")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

struct FingeringView: View {
    @State private var currentPattern = FingeringPattern(startFret: 1, pattern: "1234", string: "E (6th)")
    
    let fingeringPatterns = [
        "1234", "1243", "1324", "1342", "1423", "1432",
        "2134", "2143", "2314", "2341", "2413", "2431",
        "3124", "3142", "3214", "3241", "3412", "3421",
        "4123", "4132", "4213", "4231", "4312", "4321"
    ]
    
    let strings = ["E (6th)", "A (5th)", "D (4th)", "G (3rd)", "B (2nd)", "E (1st)"]
    let startFrets = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                VStack {
                    HStack {
                        Text("Fingering Exercise")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: generateRandomPattern) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Pattern Description
                VStack(alignment: .leading, spacing: 16) {
                    Text("Chromatic Exercise")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Play this finger pattern on consecutive frets using one finger per fret technique. Start slowly and focus on clean, even notes.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                }
                .padding()
                .background(Color(UIColor.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                // Pattern Details
                VStack(spacing: 16) {
                    ParameterCard(title: "Starting Fret", value: String(currentPattern.startFret), icon: "number")
                    ParameterCard(title: "String", value: currentPattern.string, icon: "guitars")
                    
                    // Finger Pattern Display
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 16) {
                            Image(systemName: "hand.point.up.left")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Finger Pattern")
                                    .font(.caption.weight(.medium))
                                    .foregroundColor(.secondary)
                                Text(currentPattern.pattern.map { String($0) }.joined(separator: " "))
                                    .font(.title.weight(.bold))
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                        // Fret Numbers
                        HStack(spacing: 16) {
                            Image(systemName: "music.note.list")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Frets to Play")
                                    .font(.caption.weight(.medium))
                                    .foregroundColor(.secondary)
                                Text(generateFretNumbers())
                                    .font(.title2.weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)

                }
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            generateRandomPattern()
        }
    }
    
    private func generateRandomPattern() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentPattern = FingeringPattern(
                startFret: startFrets.randomElement() ?? 1,
                pattern: fingeringPatterns.randomElement() ?? "1234",
                string: strings.randomElement() ?? "E (6th)"
            )
        }
    }
    
    private func generateFretNumbers() -> String {
        let startFret = currentPattern.startFret
        return currentPattern.pattern.map { char in
            if let digit = Int(String(char)) {
                return String(startFret + digit - 1)
            }
            return String(char)
        }.joined(separator: " - ")
    }
}

// MARK: - Fingering Pattern Model
struct FingeringPattern {
    let startFret: Int
    let pattern: String
    let string: String
}

// MARK: - Instruction Row
struct InstructionRow: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.caption.weight(.bold))
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(Color.accentColor)
                .clipShape(Circle())
            
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(nil)
            
            Spacer()
        }
    }
}

struct RandomExerciseView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "shuffle")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("Random Exercise")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text("Coming Soon")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

// MARK: - Preview
struct RandomSeventhChordsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RandomSeventhChordsView()
                .navigationTitle("7th Chords")
        }
        .preferredColorScheme(.light)
        
        NavigationView {
            RandomSeventhChordsView()
                .navigationTitle("7th Chords")
        }
        .preferredColorScheme(.dark)
    }
}