import SwiftUI

struct RandomTriadsView: View {
    @State private var currentTriads: [String] = []
    
    var body: some View {
        SimpleGridExercise(
            title: "Random Triads",
            items: currentTriads,
            columnCount: 4,
            itemHeight: 50,
            onRefresh: generateRandomTriads
        )
        .onAppear {
            if currentTriads.isEmpty {
                generateRandomTriads()
            }
        }
    }
    
    private func generateRandomTriads() {
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentTriads = Array(MusicTheoryData.triads.shuffled().prefix(ExerciseConfiguration.defaultTriadCount))
        }
    }
}