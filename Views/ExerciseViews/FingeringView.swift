import SwiftUI

struct FingeringView: View {
    @State private var currentPattern = FingeringPattern(startFret: 1, pattern: "1234", string: "E (6th)")
    
    var body: some View {
        GenericExerciseContainer(title: "Fingering Exercise", onRefresh: generateRandomPattern) {
            VStack(spacing: 20) {
                // Exercise Description
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
        }
        .onAppear {
            generateRandomPattern()
        }
    }
    
    private func generateRandomPattern() {
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentPattern = FingeringPattern(
                startFret: MusicTheoryData.fretRange.randomElement() ?? 1,
                pattern: MusicTheoryData.fingeringPatterns.randomElement() ?? "1234",
                string: MusicTheoryData.stringDescriptions.randomElement() ?? "E (6th)"
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