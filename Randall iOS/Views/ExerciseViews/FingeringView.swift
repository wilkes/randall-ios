import SwiftUI

struct FingeringView: View {
    @State private var currentPattern = FingeringPattern(startFret: 1, pattern: "1234", string: "E (6th)")
    
    var body: some View {
        GenericExerciseContainer(title: "Fingering Exercise", onRefresh: generateRandomPattern) {
            VStack(spacing: UIConfiguration.Spacing.extraLarge) {
                // Exercise Description
                VStack(alignment: .leading, spacing: UIConfiguration.Spacing.large) {
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
                .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.medium))
                .padding(.horizontal)
                
                // Pattern Details
                VStack(spacing: UIConfiguration.Spacing.large) {
                    ParameterCard(title: "Starting Fret", value: String(currentPattern.startFret), icon: "number")
                    ParameterCard(title: "String", value: currentPattern.string, icon: "guitars")
                    
                    // Finger Pattern Display
                    VStack(alignment: .leading, spacing: UIConfiguration.Spacing.medium) {
                        HStack(spacing: UIConfiguration.Spacing.large) {
                            Image(systemName: "hand.point.up.left")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .frame(width: UIConfiguration.Frame.iconWidth)
                            
                            VStack(alignment: .leading, spacing: UIConfiguration.Spacing.extraSmall) {
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
                        HStack(spacing: UIConfiguration.Spacing.large) {
                            Image(systemName: "music.note.list")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .frame(width: UIConfiguration.Frame.iconWidth)
                            
                            VStack(alignment: .leading, spacing: UIConfiguration.Spacing.extraSmall) {
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
                    .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.medium))
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            generateRandomPattern()
        }
    }
    
    private func generateRandomPattern() {
        withAnimation(UIConfiguration.Animation.defaultEasing) {
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
