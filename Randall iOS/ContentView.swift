import SwiftUI

// MARK: - Models
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

// MARK: - Data Models
struct SeventhChord {
    let name: String
}

struct TriadChord {
    let name: String
}

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

// MARK: - Content View
struct ContentView: View {
    @State private var selectedExercise: ExerciseType = .randomSeventhChords
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Compact Exercise Picker
                HStack {
                    Picker("Exercise", selection: $selectedExercise) {
                        ForEach(ExerciseType.allCases, id: \.self) { exercise in
                            Text(exercise.displayName)
                                .tag(exercise)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                // Exercise Content
                ExerciseContentView(exerciseType: selectedExercise)
                
                Spacer()
            }
            .navigationTitle("Exercises")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(UIColor.systemBackground))
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Exercise Content View
struct ExerciseContentView: View {
    let exerciseType: ExerciseType
    
    var body: some View {
        switch exerciseType {
        case .randomSeventhChords:
            RandomSeventhChordsView()
        case .goodrickOneStringVamp:
            GoodrickOneStringVampView()
        case .randomTriads:
            RandomTriadsView()
        case .krantzFormula:
            KrantzFormulaView()
        case .twelveKeys:
            TwelveKeysView()
        case .goodrickTwoStringVamp:
            GoodrickTwoStringVampView()
        case .fingering:
            FingeringView()
        case .randomExercise:
            RandomExerciseView()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}