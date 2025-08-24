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
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.clockwise")
                        Text("Refresh")
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct ParameterCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.accentColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
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
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ComingSoonView: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
                
                Text("Coming Soon")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

struct ExerciseGrid<Item: Identifiable>: View {
    let items: [Item]
    let columnCount: Int
    let itemHeight: CGFloat
    let itemContent: (Item) -> String
    
    init(
        items: [Item],
        columnCount: Int = 3,
        itemHeight: CGFloat = 60,
        itemContent: @escaping (Item) -> String
    ) {
        self.items = items
        self.columnCount = columnCount
        self.itemHeight = itemHeight
        self.itemContent = itemContent
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: columnCount), spacing: 12) {
            ForEach(items) { item in
                GridItemView(text: itemContent(item), height: itemHeight)
            }
        }
        .padding(.horizontal)
    }
}