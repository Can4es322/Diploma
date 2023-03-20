import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    @EnvironmentObject var viewModel: MapViewModel
    let points: [CLLocationCoordinate2D]
    
    func makeCoordinator() -> Coordinator {
        return Map.Coordinator()
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = viewModel.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.2362, longitude: 38.8969), latitudinalMeters: 10000, longitudinalMeters: 10000)
        view.region = region
        viewModel.setPlace()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
            
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
    }
}
