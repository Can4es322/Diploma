import SwiftUI
import MapKit

class AddAddressViewModel: ObservableObject {
    @Published var mapView = MKMapView()
    @Published var inputSearch = ""
    @Published var currentPlace = Place(id: Int.random(in: Range(1...100)), place: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 47.202477, longitude: 38.934977)))
    @Published var places: [Place] = []
    let defaultName = "Южный Федеральный Университет ИКТИБ"
    
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
}
