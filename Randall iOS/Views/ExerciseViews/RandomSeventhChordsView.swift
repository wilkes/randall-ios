import SwiftUI

struct RandomSeventhChordsView: View {
    @State private var currentChords: [String] = []
    
    var body: some View {
        SimpleGridExercise(
            title: "Random 7th Chords",
            items: currentChords,
            columnCount: 3,
            itemHeight: 60,
            onRefresh: generateRandomChords
        )
        .onAppear {
            if currentChords.isEmpty {
                generateRandomChords()
            }
        }
    }
    
    private func generateRandomChords() {
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentChords = Array(MusicTheoryData.seventhChords.shuffled().prefix(ExerciseConfiguration.defaultChordCount))
        }
    }
}
