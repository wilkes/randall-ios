import SwiftUI

struct TwelveKeysView: View {
    @State private var currentKeys: [String] = []
    
    var body: some View {
        GenericExerciseContainer(title: "12 Keys", onRefresh: generateRandomKeys) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                ForEach(currentKeys.indices, id: \.self) { index in
                    Text(currentKeys[index])
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primary)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: ExerciseConfiguration.itemCornerRadius))
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            if currentKeys.isEmpty {
                generateRandomKeys()
            }
        }
    }
    
    private func generateRandomKeys() {
        withAnimation(.easeInOut(duration: ExerciseConfiguration.animationDuration)) {
            currentKeys = MusicTheoryData.keys.shuffled()
        }
    }
}