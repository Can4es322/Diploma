import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate {
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    @Published var mapType: MKMapType = .standard
    @Published var places = [Place(id: 0, place: nil), Place(id: 1, place: nil), Place(id: 2, place: nil)]
    
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
            pointAnnotation.coordinate = place.place?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 47.202477, longitude: 38.934977)
            pointAnnotation.title = place.place?.name ?? ""
            mapView.addAnnotation(pointAnnotation)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                manager.requestLocation()
            default:
                ()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(self.region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
