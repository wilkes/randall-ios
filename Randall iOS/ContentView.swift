import SwiftUI

// MARK: - Content View
struct ContentView: View {
    @State private var selectedExercise: ExerciseType = .randomSeventhChords
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Compact Exercise Picker
                HStack {
                    Picker("Exercise", selection: $selectedExercise) {
                        ForEach(ExerciseType.allCases, id: \.self) { exercise in
                            Text(exercise.displayName)
                                .tag(exercise)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(.blue)
                    
                    Spacer()
                }
                .padding(.horizontal, UIConfiguration.Padding.horizontal)
                .padding(.vertical, UIConfiguration.Padding.vertical)
                
                // Exercise Content
                ExerciseContentView(exerciseType: selectedExercise)
                
                Spacer()
            }
            .navigationTitle("Exercises")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(UIColor.systemBackground))
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Exercise Content View
struct ExerciseContentView: View {
    let exerciseType: ExerciseType
    
    var body: some View {
        ExerciseFactory.createView(for: exerciseType)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
