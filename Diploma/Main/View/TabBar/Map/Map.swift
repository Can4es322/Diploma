import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    @EnvironmentObject private var viewModel: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let view = viewModel.mapView
        view.delegate = context.coordinator
        view.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.227725, longitude: 38.910497), latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: Map
        
        init(parent: Map) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let coordinate = view.annotation?.coordinate else { return }
            
            parent.viewModel.places.forEach { place in
                if place.latitude == coordinate.latitude && place.longitude == coordinate.longitude {
                    parent.viewModel.selectPlace = place
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            var view: CustomAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? CustomAnnotationView

            if view == nil {
                view = CustomAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            }

            view?.annotation = annotation as? CustomAnnotation

            return view
        }
    }
}
