import SwiftUI
import CoreLocation

final class MainViewModel: ObservableObject {
    @Published var inputSearch = ""
    @Published var activeTags: [Int] = []
    @Published var events: [ResponseEvent] = []
    @Published var isSelectedPhotos = false
    @Published var selectedImageId = Data()
    @Published var imageViewerOffset: CGSize = .zero
    @Published var bgOpacity: Double = 1
    @Published var imageScale: Double = 1
    
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

    var page = 0
    let service: EventServiceProtocol
    
    init(service: EventServiceProtocol = EventService()) {
        self.service = service
    }
    
    func getNews() async throws {
        do {
            let response = try await service.getEvents(page: page, size: 5)
            
            await MainActor.run {
                events = response.compactMap { $0 }
            }

        } catch {
            print("Error")
        }
    }
    
    func convertTagsRu() {
        for (indexEvent,event) in events.enumerated() {
            for (indexTag,tag) in event.tags.enumerated() {
                
                switch tag.name {
                case "Sport":
                    events[indexEvent].tags[indexTag].name = "Спорт"
                case "Science":
                    events[indexEvent].tags[indexTag].name = "Наука"
                case "Master Class":
                    events[indexEvent].tags[indexTag].name = "Спорт"
                case "Training":
                    events[indexEvent].tags[indexTag].name = "Тренинг"
                case "Conference":
                    events[indexEvent].tags[indexTag].name = "Конференция"
                case "Theater":
                    events[indexEvent].tags[indexTag].name = "Театр"
                case "Concert":
                    events[indexEvent].tags[indexTag].name = "Концерт"
                default:
                    break
                }
            }
        }
    }
    
    func addPlaceDate() {
        for (index, event) in events.enumerated() {
            getLocationName(latitude: event.latitude, longitude: event.longitude) { [weak self] name in
                self?.events[index].place = name
            }
            events[index].date = getDate(startDate: event.startDateTime, endDate: event.endDateTime)
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
    
    func onChange(value: CGSize) async {
        await MainActor.run {
            self.imageViewerOffset = value
            
            let halgHeight = UIScreen.main.bounds.height / 2
            let progress = self.imageViewerOffset.height / halgHeight
            
            withAnimation {
                self.bgOpacity = Double(1 - progress)
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) async {
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.4)) {
                let translation = value.translation.height
                
                if translation < 80 {
                    self.imageViewerOffset = .zero
                    self.bgOpacity = 1
                } else {
                    self.bgOpacity = 1
                    self.isSelectedPhotos.toggle()
                    self.imageViewerOffset.height = 500
                }
            }
        }
    }
}
