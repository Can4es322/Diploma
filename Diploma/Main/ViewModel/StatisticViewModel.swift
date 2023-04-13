import SwiftUI
import Foundation

struct SelectDate {
    var rangeInt: (startDate: Int, endDate: Int)
    var rangeString: (startDate: String?, endDate: String?)
    var rangeDate: (startDate: Date?, endDate: Date?)
}

final class StatisticViewModel: ObservableObject {
    @Published var isInfoTap = false
    @Published var offset: CGFloat = 0
    @Published var lastOffset: CGFloat = 0
    @Published var currentDate = Date()
    @Published var currentMounth = 0
    @Published var dates: [DateValue] = []
    @Published var selectedDate = SelectDate(rangeInt: (0, 0))
    
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
    
    func clearData() {
        dates = []
        selectedDate = SelectDate(rangeInt: (0, 0))
        currentMounth = 0
        currentDate = Date()
    }
    
    func tapDate(index: Int) {
        if selectedDate.rangeInt.startDate == 0 {
            selectedDate.rangeInt.startDate = dates[index].day
            selectedDate.rangeDate.startDate = dates[index].date
            selectedDate.rangeString.startDate = getMounthForText(date: dates[index].date)
            return
        }
        
        if selectedDate.rangeInt.endDate == 0 && selectedDate.rangeInt.startDate != 0 && selectedDate.rangeDate.startDate ?? Date() < dates[index].date {
            selectedDate.rangeInt.endDate = dates[index].day
            selectedDate.rangeDate.endDate = dates[index].date
            selectedDate.rangeString.endDate = getMounthForText(date: dates[index].date)
            return
        }
        
        if selectedDate.rangeDate.startDate == dates[index].date {
            selectedDate = SelectDate(rangeInt: (0,0))
            return
        }
        
        if selectedDate.rangeDate.endDate == dates[index].date {
            selectedDate.rangeInt.endDate = 0
            selectedDate.rangeDate.endDate = Date()
            selectedDate.rangeString.endDate = ""
            return
        }
    }
    
    func getMounthForText(date: Date) -> String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let index = Calendar.current.component(.month, from: date)
        
        return mounts[index] ?? ""
    }
    
    func onChange(value: CGFloat) async {
        await MainActor.run {
            self.offset = value
        }
    }
    
    func minusMounth() {
        let calendar = Calendar.current
        currentMounth -= 1
        dates = extractDate()
        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
    }
    
    func plusMounth() {
        let calendar = Calendar.current
        currentMounth += 1
        dates = extractDate()
        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
    }
    
    func extraDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date
    }
    
    func getCurrentMounth() -> Date {
        let calendar = Calendar.current
        guard let currentMounth = calendar.date(byAdding: .month, value: self.currentMounth, to: Date()) else {
            return Date()
        }
        
        return currentMounth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMounth = getCurrentMounth()

        var mountDays = currentMounth.getAllDates().compactMap({ date -> DateValue in
            // От первого дня месяца уменьшаем на единицу
            let tempDate = calendar.date(byAdding: .day, value: -1, to: date)!
            let day = calendar.component(.day, from: tempDate)
            return DateValue(day: day, date: date)
        })
    
        let tempDate = calendar.date(byAdding: .day, value: -2, to: mountDays.first?.date ?? Date())
        let firstWeekday = calendar.component(.weekday, from: tempDate!)
        
        for _ in 0..<firstWeekday - 1 {
            mountDays.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return mountDays
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap({ day -> Date in
            return calendar.date(byAdding: .day, value: day, to: startDate)!
        })
    }
}
