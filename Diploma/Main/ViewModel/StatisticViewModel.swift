import SwiftUI
import Foundation

class StatisticViewModel: ObservableObject {
    @Published var eventInfo = Event(name: "", description: "", countPerson: "", date: Date(), tags: [], place: "", avatar: UIImage(), photos: [UIImage()])
    @Published var isCategoryTap = false
    @Published var isCategoryTaps = [false, false, false, false, false, false, false]
    @Published var isNextView = false
    
    let mounts: [Int: String] = [
        1: "Январь",
        2: "Февраль",
        3: "Март",
        4: "Апрель",
        5: "Май",
        6: "Июнь",
        7: "Июль",
        8: "Август",
        9: "Сентябрь",
        10: "Октябрь",
        11: "Ноябрь",
        12: "Декабрь",
    ]
    
    func checkIsEmptyAddEvent() -> Bool {
        return eventInfo.name.isEmpty || eventInfo.description.isEmpty || eventInfo.countPerson.isEmpty || eventInfo.tags.isEmpty
    }
    
    func checkIsLimitTags() -> Bool {
        return eventInfo.tags.count > 3
    }
    
    func getCurrentMounth() -> String {
        let currentDate = Date()

        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let index = Calendar.current.component(.month, from: currentDate)
        
        return mounts[index] ?? ""
    }
}
