import SwiftUI

struct RandomSeventhChordsView: View {
    @State private var currentChords: [String] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ExerciseHeaderCard(title: "Random 7th Chords", onRefresh: generateRandomChords)
                
                // Chord Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ForEach(currentChords.indices, id: \.self) { index in
                        GridItemView(text: currentChords[index])
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
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentChords = Array(MusicTheoryData.seventhChords.shuffled().prefix(ExerciseConfiguration.defaultChordCount))
        }
    }
}