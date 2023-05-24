import SwiftUI
import MapKit

class MapViewModel: NSObject, ObservableObject, MKMapViewDelegate {
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    @Published var mapType: MKMapType = .standard
    @Published var places: [ResponseEvent] = []
    @Published var selectPlace: ResponseEvent?
    
    let service = MapService()
    let dateAndPlaceconfig = DateAndPlaceConfigurator()
    
    override init() {
        super.init()
        mapView.delegate = self
    }

    func getCoodinate() async throws {
        do {
            guard let response = try await service.getCoordinateEvents() else { return }
            
            await MainActor.run {
                places = response
                setPlace()
                addPlaceDate()
            }
        } catch {
            print(error)
        }
    }
    
    func addPlaceDate() {
        for (index, event) in places.enumerated() {
            dateAndPlaceconfig.getLocationName(latitude: event.latitude, longitude: event.longitude) {[weak self] name in
                self?.places[index].place = name
            }

            places[index].date = dateAndPlaceconfig.getDate(startDate: event.startDateTime, endDate: event.endDateTime)
        }
    }
    
    func setPlace() {
        places.forEach { place in
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            pointAnnotation.title = ""
            mapView.addAnnotation(pointAnnotation)
        }
    }
}
