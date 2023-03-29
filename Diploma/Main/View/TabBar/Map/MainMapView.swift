import SwiftUI
import MapKit
import CoreLocation

struct MainMapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            MainContent()
            
            VStack {
                Spacer()
                AdditinalContent()
                    .padding(.trailing, 10)
                    .padding(.bottom, 30)
            }
        }
        .onAppear() {
            locationManager.delegate = viewModel
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension MainMapView {
    @ViewBuilder
    func MainContent() -> some View {
        Map(points: [CLLocationCoordinate2D(latitude: 47.23, longitude: 38.89)])
            .environmentObject(viewModel)
            .edgesIgnoringSafeArea(.top)
    }
    
    @ViewBuilder
    func AdditinalContent() -> some View {
        VStack {
            Button {
                viewModel.focusLocation()
            }label: {
                Image(systemName: "location.fill")
                    .renderingMode(.template)
                    .frame(width: 17, height: 17)
                    .padding(10)
                    .background(Color("Blue5"))
                    .clipShape(Circle())
            }
            
            Button {
                viewModel.updateMapType()
            }label: {
                Image(systemName: viewModel.mapType == .standard ? "network" : "map")
                    .renderingMode(.template)
                    .frame(width: 17, height: 17)
                    .padding(10)
                    .background(Color("Blue5"))
                    .clipShape(Circle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
