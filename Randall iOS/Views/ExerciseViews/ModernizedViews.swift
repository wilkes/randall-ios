import SwiftUI

// MARK: - Modernized Exercise Views

struct ModernRandomSeventhChordsView: ExerciseView {
    @StateObject var exercise = RandomSeventhChordsExercise()
    
    var body: some View {
        SimpleGridExercise(
            title: exercise.title,
            items: exercise.currentChords,
            columnCount: ExerciseLayoutConfig.randomSeventhChords.columnCount,
            itemHeight: ExerciseLayoutConfig.randomSeventhChords.itemHeight,
            showMetronome: showMetronome,
            onRefresh: exercise.animatedRefresh
        )
        .onAppear {
            exercise.initialize()
        }
    }
}

struct ModernRandomTriadsView: ExerciseView {
    @StateObject var exercise = RandomTriadsExercise()
    
    var body: some View {
        SimpleGridExercise(
            title: exercise.title,
            items: exercise.currentTriads,
            columnCount: ExerciseLayoutConfig.randomTriads.columnCount,
            itemHeight: ExerciseLayoutConfig.randomTriads.itemHeight,
            showMetronome: showMetronome,
            onRefresh: exercise.animatedRefresh
        )
        .onAppear {
            exercise.initialize()
        }
    }
}

struct ModernTwelveKeysView: ExerciseView {
    @StateObject var exercise = TwelveKeysExercise()
    
    var body: some View {
        SimpleGridExercise(
            title: exercise.title,
            items: exercise.currentKeys,
            columnCount: ExerciseLayoutConfig.twelveKeys.columnCount,
            itemHeight: ExerciseLayoutConfig.twelveKeys.itemHeight,
            showMetronome: showMetronome,
            onRefresh: exercise.animatedRefresh
        )
        .onAppear {
            exercise.initialize()
        }
    }
}

struct ModernKrantzFormulaView: ExerciseView {
    @StateObject var exercise = KrantzFormulaExercise()
    
    var body: some View {
        GenericExerciseContainer(
            title: exercise.title,
            onRefresh: exercise.animatedRefresh,
            showMetronome: showMetronome
        ) {
            VStack(spacing: UIConfiguration.Spacing.large) {
                ParameterCard(title: "Key", value: exercise.currentFormula.key, icon: "music.note")
                ParameterCard(title: "Zone", value: exercise.currentFormula.zone, icon: "rectangle.grid.2x2")
                ParameterCard(title: "Tempo", value: exercise.currentFormula.tempo, icon: "metronome")
                
                // Formula Card (custom layout for longer text)
                HStack(spacing: UIConfiguration.Spacing.large) {
                    Image(systemName: "function")
                        .font(.title3)
                        .foregroundColor(.accentColor)
                        .frame(width: UIConfiguration.Frame.iconWidth)
                    
                    VStack(alignment: .leading, spacing: UIConfiguration.Spacing.extraSmall) {
                        Text("Formula")
                            .font(.caption.weight(.medium))
                            .foregroundColor(.secondary)
                        Text(exercise.currentFormula.formula)
                            .font(.body.weight(.medium))
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.medium))
            }
            .padding(.horizontal)
        }
        .onAppear {
            exercise.initialize()
        }
    }
}

// MARK: - Exercise View Factory
struct ExerciseViewFactory {
    
    @ViewBuilder
    static func createModernView(for exerciseType: ExerciseType) -> some View {
        switch exerciseType {
        case .randomSeventhChords:
            ModernRandomSeventhChordsView()
        case .randomTriads:
            ModernRandomTriadsView()
        case .krantzFormula:
            ModernKrantzFormulaView()
        case .twelveKeys:
            ModernTwelveKeysView()
        case .goodrickOneStringVamp:
            GoodrickOneStringVampView() // Keep existing for now
        case .goodrickTwoStringVamp:
            GoodrickTwoStringVampView() // Keep existing for now
        case .fingering:
            FingeringView() // Keep existing for now
        case .randomExercise:
            RandomExerciseView() // Keep existing for now
        }
    }
}