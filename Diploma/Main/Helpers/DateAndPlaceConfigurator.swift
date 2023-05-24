import CoreLocation

class DateAndPlaceConfigurator {
    private enum DayOfWeek: String, CaseIterable {
        case Sunday = "Вс"
        case Monday = "Пн"
        case Tuesday = "Вт"
        case Wednesday = "Ср"
        case Thursday = "Чт"
        case Friday = "Пт"
        case Saturday = "Сб"
        
        static func getWeek(_ index: Int) -> DayOfWeek.RawValue {
            var count = 1
            for week in DayOfWeek.allCases {
                if count == index {
                    return week.rawValue
                }
                count += 1
            }
            return ""
        }
    }
    
    func getLocationName(latitude: Double, longitude: Double, completion: @escaping (String) -> Void ) {
        let geoCoder = CLGeocoder()

        geoCoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
            guard let placemarks = placemarks, let name = placemarks.first?.name else { return }
            completion(name)
        }
    }

    func getDate(startDate: String, endDate: String) -> String {
        
        let dateFormatter = ISO8601DateFormatter()
        guard let start = dateFormatter.date(from: startDate + "+0300") else { return ""}
        guard let end = dateFormatter.date(from: endDate + "+0300") else { return ""}
        
        let startDateComponent = Calendar.current.dateComponents([.day, .month, .weekday], from: start)
        let endDateComponent = Calendar.current.dateComponents([.day, .month, .weekday], from: end)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        var newStartString = ""
        
        if startDateComponent.month == endDateComponent.month && startDateComponent.day == endDateComponent.day {
            formatter.dateFormat = "dd MMMM - HH:mm"
            
            let week = DayOfWeek.getWeek(startDateComponent.weekday ?? 1)
            newStartString = week + ", "
            
            newStartString += formatter.string(from: start)
            formatter.dateFormat = "HH:mm"
            newStartString += " - "
            newStartString += formatter.string(from: end)

            return newStartString
        } else {
            formatter.dateFormat = "dd MMMM"
            newStartString += formatter.string(from: start)
            newStartString += " - "
            newStartString += formatter.string(from: end)
            newStartString += ". Начало в "
            formatter.dateFormat = "HH:mm"
            newStartString += formatter.string(from: start)
            
            return newStartString
        }
    }
}
