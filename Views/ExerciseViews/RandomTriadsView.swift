import SwiftUI

struct RandomTriadsView: View {
    @State private var currentTriads: [String] = []
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ExerciseHeaderCard(title: "Random Triads", onRefresh: generateRandomTriads)
                
                // Triad Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ForEach(currentTriads.indices, id: \.self) { index in
                        GridItemView(text: currentTriads[index], height: 50)
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
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentTriads = Array(MusicTheoryData.triads.shuffled().prefix(ExerciseConfiguration.defaultTriadCount))
        }
    }
}