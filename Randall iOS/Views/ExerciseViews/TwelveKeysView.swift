import SwiftUI

struct TwelveKeysView: View {
    @State private var currentKeys: [String] = []
    
    var body: some View {
        GenericExerciseContainer(title: "12 Keys", onRefresh: generateRandomKeys) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: ExerciseLayoutConfig.twelveKeys.spacing), count: ExerciseLayoutConfig.twelveKeys.columnCount), spacing: ExerciseLayoutConfig.twelveKeys.spacing) {
                ForEach(currentKeys.indices, id: \.self) { index in
                    Text(currentKeys[index])
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primary)
                        .frame(height: ExerciseLayoutConfig.twelveKeys.itemHeight)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.small))
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
        withAnimation(UIConfiguration.Animation.defaultEasing) {
            currentKeys = MusicTheoryData.keys.shuffled()
        }
    }
}
