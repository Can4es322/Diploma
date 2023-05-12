import SwiftUI
import CoreLocation

final class MainViewModel: ObservableObject {
    @Published var inputSearch = ""
    @Published var activeTags: [String] = []
    @Published var events: [ResponseEvent] = []
    @Published var isSelectedPhotos = false
    @Published var selectedImageId = Data()
    @Published var imageViewerOffset: CGSize = .zero
    @Published var bgOpacity: Double = 1
    @Published var imageScale: Double = 1
    
    let tags = ["Наука", "Мастер-класс", "Конференция", "Театр", "Спорт", "Тренинг", "Концерт"]
    let dictinaryTags = ["Наука":"Science", "Мастер-класс":"Master Class", "Конференция":"Conference", "Театр":"Theater", "Спорт":"Sport", "Тренинг":"Training", "Концерт":"Concert"]

    var page = 0
    let service: EventServiceProtocol
    let dateAndPlaceconfig = DateAndPlaceConfigurator()
    
    
    init(service: EventServiceProtocol = EventService()) {
        self.service = service
    }
    
    func getEvents() async throws {
        do {
            let response = try await service.getEvents(page: page, size: 5)
            
            await MainActor.run {
                events = response.compactMap { $0 }
                addPlaceDate()
                convertTagsRu()
            }

        } catch {
            print("Error")
        }
    }
    

    
    func getSearchEvents() async throws {
        do {
            let response = try await service.getSearchEvents(title: inputSearch)
            
            await MainActor.run {
                events = response.compactMap { $0 }
                addPlaceDate()
                convertTagsRu()
            }
        }catch {
            print("Error")
        }
    }
    
    func getSearchTagEvents() async throws {
        do {
            let tags = activeTags.map { text -> String in dictinaryTags[text] ?? "" }
            let response = try await service.getSearchTagEvents(tags: tags)
            
            await MainActor.run {
                events = response.compactMap { $0 }
                addPlaceDate()
                convertTagsRu()
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
                    events[indexEvent].tags[indexTag].ruName = "Спорт"
                case "Science":
                    events[indexEvent].tags[indexTag].ruName = "Наука"
                case "Master Class":
                    events[indexEvent].tags[indexTag].ruName = "Мастер класс"
                case "Training":
                    events[indexEvent].tags[indexTag].ruName = "Тренинг"
                case "Conference":
                    events[indexEvent].tags[indexTag].ruName = "Конференция"
                case "Theater":
                    events[indexEvent].tags[indexTag].ruName = "Театр"
                case "Concert":
                    events[indexEvent].tags[indexTag].ruName = "Концерт"
                default:
                    break
                }
            }
        }
    }
    
    func addPlaceDate() {
        for (index, event) in events.enumerated() {
            dateAndPlaceconfig.getLocationName(latitude: event.latitude, longitude: event.longitude) {[weak self] name in
                self?.events[index].place = name
            }

            events[index].date = dateAndPlaceconfig.getDate(startDate: event.startDateTime, endDate: event.endDateTime)
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
