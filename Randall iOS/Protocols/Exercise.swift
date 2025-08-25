import SwiftUI

// MARK: - Exercise Protocol
@MainActor
protocol ExerciseProtocol: ObservableObject {
    /// The unique identifier for this exercise
    var id: UUID { get }
    
    /// The display name for this exercise
    var title: String { get }
    
    /// Whether the exercise has data loaded and ready to display
    var isLoaded: Bool { get }
    
    /// Generates new exercise content
    func refresh()
    
    /// Initializes the exercise with default content if needed
    func initialize()
    
    /// Metadata about the exercise for configuration and display
    var metadata: ExerciseMetadata { get }
}

// MARK: - Exercise Protocol Extension
extension ExerciseProtocol {
    /// Default initialization - can be overridden by conforming types
    func initialize() {
        if !isLoaded {
            refresh()
        }
    }
    
    /// Animation configuration for content updates
    var refreshAnimation: Animation {
        UIConfiguration.Animation.defaultEasing
    }
    
    /// Performs refresh with standard animation
    func animatedRefresh() {
        withAnimation(refreshAnimation) {
            refresh()
        }
    }
}

// MARK: - Exercise View Protocol
protocol ExerciseView: View {
    associatedtype ExerciseModel: ExerciseProtocol
    
    /// The exercise model that provides data and business logic
    var exercise: ExerciseModel { get }
    
    /// Whether this exercise should display a metronome
    var showMetronome: Bool { get }
}

// MARK: - Exercise View Extension
extension ExerciseView {
    /// Default metronome visibility - most exercises show metronome
    var showMetronome: Bool { true }
}

