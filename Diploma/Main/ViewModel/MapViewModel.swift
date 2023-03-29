import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate{
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    @Published var mapType: MKMapType = .standard
    @Published var places = [Place(id: 0, place: (12,12), name: "Place 1"), Place(id: 1, place: (22,22), name: "Place 2"), Place(id: 2, place: (32,32), name: "Place 3")]
    
    override init() {
        super.init()
        mapView.delegate = self
    }
    
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func setPlace() {
        places.forEach { place in
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: place.place.0, longitude: place.place.1)
            pointAnnotation.title = place.name
            mapView.addAnnotation(pointAnnotation)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            default:
                ()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
