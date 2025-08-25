import SwiftUI

struct GoodrickOneStringVampView: View {
    @State private var currentVamp = GoodrickVamp(string: "B", key: "Db", mode: "Locrian", tempo: "123")
    
    private var parameters: [ExerciseParameter] {
        [
            ExerciseParameter(title: "String", value: currentVamp.string, icon: "guitars"),
            ExerciseParameter(title: "Key", value: currentVamp.key, icon: "music.note"),
            ExerciseParameter(title: "Mode", value: currentVamp.mode, icon: "waveform"),
            ExerciseParameter(title: "Tempo", value: currentVamp.tempo, icon: "metronome")
        ]
    }
    
    var body: some View {
        ParameterExercise(
            title: "Goodrick One String Vamp",
            parameters: parameters,
            onRefresh: generateRandomVamp
        )
        .onAppear {
            generateRandomVamp()
        }
    }
    
    private func generateRandomVamp() {
        withAnimation(UIConfiguration.Animation.defaultEasing) {
            currentVamp = GoodrickVamp(
                string: MusicTheoryData.guitarStrings.randomElement() ?? "B",
                key: MusicTheoryData.keys.randomElement() ?? "Db",
                mode: MusicTheoryData.modes.randomElement() ?? "Locrian",
                tempo: String(Int.random(in: MusicTheoryData.tempoRange))
            )
        }
    }
}
