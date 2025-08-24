import SwiftUI

struct KrantzFormulaView: View {
    @State private var currentFormula = KrantzFormula(key: "C", zone: "6 7 8 9", tempo: "74", formula: "1 2 b3 3 4 b5 5 7")
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ExerciseHeaderCard(title: "Krantz Formula", onRefresh: generateRandomFormula)
                
                // Parameter Cards
                VStack(spacing: 16) {
                    ParameterCard(title: "Key", value: currentFormula.key, icon: "music.note")
                    ParameterCard(title: "Zone", value: currentFormula.zone, icon: "rectangle.grid.2x2")
                    ParameterCard(title: "Tempo", value: currentFormula.tempo, icon: "metronome")
                    
                    // Formula Card (custom layout for longer text)
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
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentFormula = KrantzFormula(
                key: MusicTheoryData.keys.randomElement() ?? "C",
                zone: MusicTheoryData.krantzZones.randomElement() ?? "6 7 8 9",
                tempo: String(Int.random(in: MusicTheoryData.tempoRange)),
                formula: MusicTheoryData.krantzFormulas.randomElement() ?? "1 2 b3 3 4 b5 5 7"
            )
        }
    }
}