import SwiftUI
import MapKit

struct MapAddAddress: UIViewRepresentable {
    @ObservedObject var viewModel: AddEventViewModel
    let coordinate = CLLocationCoordinate2D(latitude: 47.202477, longitude: 38.934977)
    
    func makeUIView(context: Context) -> MKMapView {
        let view = viewModel.mapView
        view.delegate = context.coordinator
        
        let regionUFU = MKCoordinateRegion(center: viewModel.currentPlace.place?.location?.coordinate ?? coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        view.region = regionUFU
        
        let draggableAnnotation = MKPointAnnotation()
        draggableAnnotation.coordinate = viewModel.currentPlace.place?.location?.coordinate ?? coordinate

        view.addAnnotation(draggableAnnotation)
        view.selectAnnotation(draggableAnnotation, animated: true)
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapAddAddress
        
        init(parent: MapAddAddress) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            view.transform = view.transform.scaledBy(x: 0.85, y: 0.85)
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            view.transform = .identity
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            var view: CustomAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? CustomAnnotationView
            if view == nil {
                view = CustomAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            }

            view?.annotation = annotation as? CustomAnnotation
            view?.isDraggable = true
            
            return view
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            guard let latitude = view.annotation?.coordinate.latitude else { return }
            guard let longitude = view.annotation?.coordinate.longitude else { return }
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { [weak self] (places, err) in
                self?.parent.viewModel.currentPlace.place = places?.first
            }
        }
    }
}
