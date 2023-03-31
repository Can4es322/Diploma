import SwiftUI
import Foundation

class StatisticViewModel: ObservableObject {
    @Published var isInfoTap = false
    
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
    
    func getCurrentMounth() -> String {
        let currentDate = Date()

        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let index = Calendar.current.component(.month, from: currentDate)
        
        return mounts[index] ?? ""
    }
}
