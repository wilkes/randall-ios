import SwiftUI

struct GoodrickOneStringVampView: View {
    @State private var currentVamp = GoodrickVamp(string: "B", key: "Db", mode: "Locrian", tempo: "123")
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ExerciseHeaderCard(title: "Goodrick One String Vamp", onRefresh: generateRandomVamp)
                
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
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentVamp = GoodrickVamp(
                string: MusicTheoryData.guitarStrings.randomElement() ?? "B",
                key: MusicTheoryData.keys.randomElement() ?? "Db",
                mode: MusicTheoryData.modes.randomElement() ?? "Locrian",
                tempo: String(Int.random(in: MusicTheoryData.tempoRange))
            )
        }
    }
}