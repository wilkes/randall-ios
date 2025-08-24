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
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: UIConfiguration.Spacing.extraLarge) {
                ExerciseHeaderCard(title: title, onRefresh: onRefresh)
                
                content()
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemBackground))
    }
}

// MARK: - Simple String Grid Container
struct SimpleGridExercise: View {
    let title: String
    let items: [String]
    let columnCount: Int
    let itemHeight: CGFloat
    let onRefresh: () -> Void
    
    init(
        title: String,
        items: [String],
        columnCount: Int = UIConfiguration.Grid.defaultColumnCount,
        itemHeight: CGFloat = UIConfiguration.Grid.defaultItemHeight,
        onRefresh: @escaping () -> Void
    ) {
        self.title = title
        self.items = items
        self.columnCount = columnCount
        self.itemHeight = itemHeight
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        GenericExerciseContainer(title: title, onRefresh: onRefresh) {
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
