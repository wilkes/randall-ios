import Testing
@testable import Randall_iOS
import SwiftUI

// MARK: - Exercise Factory Tests
struct ExerciseFactoryTests {
    
    @Test("Factory creates view for all exercise types")
    func factoryCreatesViewForAllTypes() {
        for exerciseType in Randall_iOS.ExerciseType.allCases {
            let view = Randall_iOS.ExerciseFactory.createView(for: exerciseType)
            // Verify view can be created without crashing
            _ = view.body
        }
    }
    
    @Test("Factory provides metadata for all exercise types")
    func factoryProvidesMetadataForAllTypes() {
        for exerciseType in Randall_iOS.ExerciseType.allCases {
            let metadata = Randall_iOS.ExerciseFactory.getMetadata(for: exerciseType)
            
            #expect(!metadata.title.isEmpty)
            #expect(metadata.estimatedDuration > 0)
            #expect(metadata.estimatedDuration <= 30) // Reasonable upper limit
        }
    }
    
    @Test("Exercise categories have valid icons")
    func exerciseCategoriesHaveValidIcons() {
        for category in Randall_iOS.ExerciseCategory.allCases {
            #expect(!category.icon.isEmpty)
            #expect(category.rawValue != "")
        }
    }
    
    @Test("Exercise difficulties have valid colors")
    func exerciseDifficultiesHaveValidColors() {
        for difficulty in Randall_iOS.ExerciseDifficulty.allCases {
            #expect(!difficulty.color.isEmpty)
            #expect(difficulty.rawValue != "")
        }
    }
    
    @Test("Specific exercise type mappings are correct")
    func specificExerciseTypeMappingsAreCorrect() {
        let metadata = Randall_iOS.ExerciseFactory.getMetadata(for: .randomSeventhChords)
        #expect(metadata.title == "Random 7th Chords")
        #expect(metadata.category == .chords)
        #expect(metadata.difficulty == .beginner)
        
        let krantzMetadata = Randall_iOS.ExerciseFactory.getMetadata(for: .krantzFormula)
        #expect(krantzMetadata.category == .scales)
        #expect(krantzMetadata.difficulty == .advanced)
        
        let fingeringMetadata = Randall_iOS.ExerciseFactory.getMetadata(for: .fingering)
        #expect(fingeringMetadata.category == .technique)
    }
    
    @Test("Exercise metadata duration is reasonable")
    func exerciseMetadataDurationIsReasonable() {
        let allMetadata = Randall_iOS.ExerciseType.allCases.map { Randall_iOS.ExerciseFactory.getMetadata(for: $0) }
        
        for metadata in allMetadata {
            #expect(metadata.estimatedDuration >= 3) // At least 3 minutes
            #expect(metadata.estimatedDuration <= 20) // No more than 20 minutes
        }
    }
    
    @Test("Exercise categories are distributed properly")
    func exerciseCategoriesAreDistributedProperly() {
        let allMetadata = Randall_iOS.ExerciseType.allCases.map { Randall_iOS.ExerciseFactory.getMetadata(for: $0) }
        let categories = Set(allMetadata.map { $0.category })
        
        // Should have multiple categories represented
        #expect(categories.count >= 3)
        #expect(categories.contains(.chords))
        #expect(categories.contains(.scales))
    }
}
