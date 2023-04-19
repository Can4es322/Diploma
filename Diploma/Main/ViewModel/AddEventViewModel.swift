import SwiftUI

class AddEventViewModel: ObservableObject {
    @Published var eventInfo = Event(name: "", description: "", countPerson: "", date: Date(), tags: [])
    @Published var isCategoryTap = false
    @Published var isCategoryTaps = [false, false, false, false, false, false, false]
    @Published var isNextView = false
    
    func checkIsEmptyAddEvent() -> Bool {
        return eventInfo.name.isEmpty || eventInfo.description.isEmpty || eventInfo.countPerson.isEmpty || eventInfo.tags.isEmpty
    }
    
    func checkIsLimitTags() -> Bool {
        return eventInfo.tags.count > 3
    }
}
