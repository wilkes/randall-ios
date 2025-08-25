import SwiftUI

// MARK: - Reusable UI Components

struct ExerciseHeaderCard: View {
    let title: String
    let onRefresh: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: onRefresh) {
                    HStack(spacing: UIConfiguration.Spacing.small) {
                        Image(systemName: "arrow.clockwise")
                        Text("Refresh")
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, UIConfiguration.Padding.medium)
                    .padding(.vertical, UIConfiguration.Padding.small)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.large))
        .padding(.horizontal)
    }
}

struct ParameterCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: UIConfiguration.Spacing.large) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.accentColor)
                .frame(width: UIConfiguration.Frame.iconWidth)
            
            VStack(alignment: .leading, spacing: UIConfiguration.Spacing.extraSmall) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.title3.weight(.medium))
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct GridItemView: View {
    let text: String
    let height: CGFloat
    
    init(text: String, height: CGFloat = 60) {
        self.text = text
        self.height = height
    }
    
    var body: some View {
        Text(text)
            .font(.title3.weight(.medium))
            .foregroundColor(.primary)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.small))
    }
}

struct ComingSoonView: View {
    let title: String
    let icon: String
    
    var body: some View {
        GenericExerciseContainer(title: title, onRefresh: {}, content: {
            VStack(spacing: UIConfiguration.Spacing.xxlarge) {
                Image(systemName: icon)
                    .font(.system(size: 48))
                    .foregroundColor(.secondary)
                
                Text("Coming Soon")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, UIConfiguration.Frame.topPadding)
        })
    }
}

struct ExerciseGrid<Item: Identifiable>: View {
    let items: [Item]
    let columnCount: Int
    let itemHeight: CGFloat
    let itemContent: (Item) -> String
    
    init(
        items: [Item],
        columnCount: Int = UIConfiguration.Grid.defaultColumnCount,
        itemHeight: CGFloat = UIConfiguration.Grid.defaultItemHeight,
        itemContent: @escaping (Item) -> String
    ) {
        self.items = items
        self.columnCount = columnCount
        self.itemHeight = itemHeight
        self.itemContent = itemContent
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: UIConfiguration.Grid.defaultSpacing), count: columnCount), spacing: UIConfiguration.Grid.defaultSpacing) {
            ForEach(items) { item in
                GridItemView(text: itemContent(item), height: itemHeight)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Generic Exercise Container
struct GenericExerciseContainer<Content: View>: View {
    let title: String
    let onRefresh: () -> Void
    let showMetronome: Bool
    @ViewBuilder let content: () -> Content
    @StateObject private var metronome = MetronomeService()
    
    init(title: String, onRefresh: @escaping () -> Void, showMetronome: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.onRefresh = onRefresh
        self.showMetronome = showMetronome
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: UIConfiguration.Spacing.extraLarge) {
                ExerciseHeaderCard(title: title, onRefresh: onRefresh)
                
                if showMetronome {
                    VStack(spacing: UIConfiguration.Spacing.medium) {
                        MetronomeControls(metronome: metronome)
                        TempoPresets(metronome: metronome)
                    }
                    .padding(.horizontal)
                }
                
                content()
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
        .onDisappear {
            // Stop metronome when leaving exercise
            metronome.stop()
        }
    }
}

// MARK: - Simple String Grid Container
struct SimpleGridExercise: View {
    let title: String
    let items: [String]
    let columnCount: Int
    let itemHeight: CGFloat
    let showMetronome: Bool
    let onRefresh: () -> Void
    
    init(
        title: String,
        items: [String],
        columnCount: Int = UIConfiguration.Grid.defaultColumnCount,
        itemHeight: CGFloat = UIConfiguration.Grid.defaultItemHeight,
        showMetronome: Bool = true,
        onRefresh: @escaping () -> Void
    ) {
        self.title = title
        self.items = items
        self.columnCount = columnCount
        self.itemHeight = itemHeight
        self.showMetronome = showMetronome
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        GenericExerciseContainer(title: title, onRefresh: onRefresh, showMetronome: showMetronome) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: UIConfiguration.Grid.defaultSpacing), count: columnCount), spacing: UIConfiguration.Grid.defaultSpacing) {
                ForEach(items.indices, id: \.self) { index in
                    GridItemView(text: items[index], height: itemHeight)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Parameter Cards Exercise Container
struct ParameterExercise: View {
    let title: String
    let parameters: [ExerciseParameter]
    let onRefresh: () -> Void
    
    var body: some View {
        GenericExerciseContainer(title: title, onRefresh: onRefresh) {
            VStack(spacing: UIConfiguration.Spacing.large) {
                ForEach(parameters) { parameter in
                    ParameterCard(title: parameter.title, value: parameter.value, icon: parameter.icon)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Metronome Controls
struct MetronomeControls: View {
    @ObservedObject var metronome: MetronomeService
    
    var body: some View {
        VStack(spacing: UIConfiguration.Spacing.medium) {
            // Tempo Display and Controls
            HStack(spacing: UIConfiguration.Spacing.large) {
                // Tempo Decrease
                Button(action: { decreaseTempo() }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .disabled(metronome.tempo <= MetronomeService.tempoRange.lowerBound)
                
                // Tempo Display
                VStack(spacing: UIConfiguration.Spacing.extraSmall) {
                    Text("\(Int(metronome.tempo))")
                        .font(.title.weight(.bold))
                        .monospacedDigit()
                    Text("BPM")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(minWidth: 60)
                
                // Tempo Increase
                Button(action: { increaseTempo() }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .disabled(metronome.tempo >= MetronomeService.tempoRange.upperBound)
            }
            
            // Beat Indicator
            HStack(spacing: UIConfiguration.Spacing.small) {
                ForEach(1...metronome.beatsPerMeasure, id: \.self) { beat in
                    Circle()
                        .fill(beat == metronome.currentBeat ? Color.accentColor : Color.secondary.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .scaleEffect(beat == metronome.currentBeat ? 1.5 : 1.0)
                        .animation(UIConfiguration.Animation.beatIndicator, value: metronome.currentBeat)
                }
            }
            
            // Play/Stop Button
            Button(action: { metronome.toggle() }) {
                HStack(spacing: UIConfiguration.Spacing.small) {
                    Image(systemName: metronome.isPlaying ? "pause.fill" : "play.fill")
                    Text(metronome.isPlaying ? "Stop" : "Start")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, UIConfiguration.Padding.medium)
                .padding(.vertical, UIConfiguration.Padding.small)
                .background(metronome.isPlaying ? Color.red : Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.small))
            }
        }
        .padding(.vertical, UIConfiguration.Padding.small)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.medium))
    }
    
    private func increaseTempo() {
        let increment: Double = metronome.tempo < 100 ? 1 : 5
        metronome.setTempo(metronome.tempo + increment)
    }
    
    private func decreaseTempo() {
        let decrement: Double = metronome.tempo <= 100 ? 1 : 5
        metronome.setTempo(metronome.tempo - decrement)
    }
}

// MARK: - Tempo Presets
struct TempoPresets: View {
    @ObservedObject var metronome: MetronomeService
    
    var body: some View {
        HStack(spacing: UIConfiguration.Spacing.small) {
            ForEach(MetronomeService.TempoPreset.allCases, id: \.name) { preset in
                Button(action: { metronome.setTempo(preset.tempo) }) {
                    Text(preset.name)
                        .font(.caption.weight(.medium))
                        .foregroundColor(isActivePreset(preset) ? .white : .secondary)
                        .padding(.horizontal, UIConfiguration.Padding.small)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.small)
                                .fill(isActivePreset(preset) ? Color.accentColor : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: UIConfiguration.CornerRadius.small)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )
                }
            }
        }
    }
    
    private func isActivePreset(_ preset: MetronomeService.TempoPreset) -> Bool {
        preset.range.contains(metronome.tempo)
    }
}

// MARK: - Exercise Parameter Model
struct ExerciseParameter: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    
    init(title: String, value: String, icon: String) {
        self.title = title
        self.value = value
        self.icon = icon
    }
}
