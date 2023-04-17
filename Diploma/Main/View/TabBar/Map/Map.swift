import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    @EnvironmentObject private var viewModel: MapViewModel
    let points: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let view = viewModel.mapView
        view.showsUserLocation = true

        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.2362, longitude: 38.8969), latitudinalMeters: 10000, longitudinalMeters: 10000)
        view.region = region
        viewModel.setPlace()
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
}
