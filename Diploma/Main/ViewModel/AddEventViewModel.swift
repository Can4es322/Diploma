import SwiftUI
import MapKit

class AddEventViewModel: ObservableObject {
    @Published var eventInfo = Event(name: "", description: "", countPerson: "", startDate: Date(), endDate: Date(), tags: [])
    @Published var isCategoryTap = false
    @Published var isCategoryTaps = [false, false, false, false, false, false, false]
    @Published var isNextView = false
    @Published var mapView = MKMapView()
    @Published var inputSearch = ""
    @Published var currentPlace = Place(id: Int.random(in: Range(1...100)), place: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 47.202477, longitude: 38.934977)))
    @Published var places: [Place] = []
    @Published var isPhotoPickerSheet = false
    @Published var imageData = EventImage(images: [], avatar: nil)
    let defaultName = "Южный Федеральный Университет ИКТИБ"
    let service: EventServiceProtocol
    
    init(service: EventServiceProtocol = EventService()) {
        self.service = service
    }
    
    func addEvent() async throws {
        do {
            guard let avatar = imageData.avatar?.pngData() else { return }
            
            let tagRequest = eventInfo.tags.map { tag -> TagRequest in
                TagRequest(name: tag)
            }

            let imageRequest = imageData.images.map { image -> ImageRequest in
                if let imageData = image.pngData() {
                    return ImageRequest(imageData: imageData)
                }
                return ImageRequest(imageData: Data())
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd'T'HH:mm"
            let strStartDate = formatter.string(from: eventInfo.startDate)
            
            formatter.dateFormat = "YYYY-MM-dd'T'HH:mm"
            let strEndDate = formatter.string(from: eventInfo.endDate)
            
            let request = EventRequest(title: eventInfo.name, avatar: avatar, countPeopleMax: Int(eventInfo.countPerson) ?? 0, countPeople: 0, description: eventInfo.description, latitude: currentPlace.place?.location?.coordinate.latitude ?? 0.0, longitude: currentPlace.place?.location?.coordinate.longitude ?? 0.0, startDateTime: strStartDate, endDateTime: strEndDate, tags: tagRequest, images: imageRequest)
            
            guard let responseId = try await service.addEvent(request: request) else { return }
            
            let responseUpdate = try await service.updateEvent(request: request, id: responseId)
            
        } catch {
            print(error)
        }
    }
    
    func searchLocationPoint() {
        places.removeAll()

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = inputSearch
        
        MKLocalSearch(request: request).start { [weak self] (result, error) in
            guard let self = self else { return }
            guard let result = result else { return }

            self.places = result.mapItems.compactMap { (element) -> Place? in
                print(element)
                return Place(id: Int.random(in: Range(10...10000)), place: element.placemark)
            }
        }
    }
    
    func tapPlace(place: Place) {
        inputSearch = ""
        currentPlace = place
        guard let coordinate = place.place?.location?.coordinate else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = place.place?.name ?? ""
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
       
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    func checkIsEmptyAddEvent() -> Bool {
        return eventInfo.name.isEmpty || eventInfo.description.isEmpty || eventInfo.countPerson.isEmpty || eventInfo.tags.isEmpty
    }
    
    func checkIsLimitTags() -> Bool {
        return eventInfo.tags.count > 3
    }
}
