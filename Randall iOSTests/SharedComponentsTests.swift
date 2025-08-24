import Testing
import SwiftUI
@testable import Randall_iOS

@MainActor
struct SharedComponentsTests {
    
    // MARK: - ExerciseParameter Tests
    
    @Test("ExerciseParameter creates unique IDs")
    func exerciseParameterUniqueIDs() {
        let param1 = ExerciseParameter(title: "Key", value: "C", icon: "music.note")
        let param2 = ExerciseParameter(title: "Tempo", value: "120", icon: "metronome")
        
        #expect(param1.id != param2.id)
    }
    
    @Test("ExerciseParameter stores correct values")
    func exerciseParameterValues() {
        let parameter = ExerciseParameter(title: "Key", value: "C", icon: "music.note")
        
        #expect(parameter.title == "Key")
        #expect(parameter.value == "C")
        #expect(parameter.icon == "music.note")
    }
    
    // MARK: - ExerciseHeaderCard Tests
    
    @Test("ExerciseHeaderCard displays title")
    func exerciseHeaderCardTitle() {
        var refreshCalled = false
        let headerCard = ExerciseHeaderCard(title: "Test Exercise") {
            refreshCalled = true
        }
        
        // Test that the view can be created without errors
        #expect(headerCard.title == "Test Exercise")
    }
    
    // MARK: - ParameterCard Tests
    
    @Test("ParameterCard stores correct values")
    func parameterCardValues() {
        let card = ParameterCard(title: "Key", value: "C", icon: "music.note")
        
        #expect(card.title == "Key")
        #expect(card.value == "C") 
        #expect(card.icon == "music.note")
    }
    
    // MARK: - GridItemView Tests
    
    @Test("GridItemView with default height")
    func gridItemViewDefaultHeight() {
        let item = GridItemView(text: "Test")
        
        #expect(item.text == "Test")
        #expect(item.height == 60) // Default height
    }
    
    @Test("GridItemView with custom height")
    func gridItemViewCustomHeight() {
        let item = GridItemView(text: "Test", height: 80)
        
        #expect(item.text == "Test")
        #expect(item.height == 80)
    }
    
    // MARK: - ComingSoonView Tests
    
    @Test("ComingSoonView stores correct values")
    func comingSoonViewValues() {
        let view = ComingSoonView(title: "Future Feature", icon: "gear")
        
        #expect(view.title == "Future Feature")
        #expect(view.icon == "gear")
    }
    
    // MARK: - SimpleGridExercise Tests
    
    @Test("SimpleGridExercise with default parameters")
    func simpleGridExerciseDefaults() {
        var refreshCalled = false
        let items = ["C", "D", "E"]
        
        let exercise = SimpleGridExercise(
            title: "Test Grid",
            items: items,
            onRefresh: { refreshCalled = true }
        )
        
        #expect(exercise.title == "Test Grid")
        #expect(exercise.items == items)
        #expect(exercise.columnCount == 3) // Default
        #expect(exercise.itemHeight == 60) // Default
    }
    
    @Test("SimpleGridExercise with custom parameters")
    func simpleGridExerciseCustom() {
        var refreshCalled = false
        let items = ["C", "D", "E", "F"]
        
        let exercise = SimpleGridExercise(
            title: "Custom Grid",
            items: items,
            columnCount: 4,
            itemHeight: 80,
            onRefresh: { refreshCalled = true }
        )
        
        #expect(exercise.title == "Custom Grid")
        #expect(exercise.items == items)
        #expect(exercise.columnCount == 4)
        #expect(exercise.itemHeight == 80)
    }
    
    // MARK: - ParameterExercise Tests
    
    @Test("ParameterExercise stores values correctly")
    func parameterExerciseValues() {
        var refreshCalled = false
        let parameters = [
            ExerciseParameter(title: "Key", value: "C", icon: "music.note"),
            ExerciseParameter(title: "Tempo", value: "120", icon: "metronome")
        ]
        
        let exercise = ParameterExercise(
            title: "Test Parameters",
            parameters: parameters,
            onRefresh: { refreshCalled = true }
        )
        
        #expect(exercise.title == "Test Parameters")
        #expect(exercise.parameters.count == 2)
        #expect(exercise.parameters[0].title == "Key")
        #expect(exercise.parameters[1].title == "Tempo")
    }
}