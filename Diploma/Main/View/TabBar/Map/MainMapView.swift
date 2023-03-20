import SwiftUI
import MapKit
import CoreLocation

struct MainMapView: View {
    @StateObject var viewModel = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            Map(points: [CLLocationCoordinate2D(latitude: 47.23, longitude: 38.89)])
                .environmentObject(viewModel)
                .edgesIgnoringSafeArea(.top)
                .onAppear() {
                    locationManager.delegate = viewModel
                    locationManager.requestWhenInUseAuthorization()
                }
                .alert(isPresented: $viewModel.permission) {
                    Alert(title: Text("Permission Denied"),
                          message: Text("Pleas Enable Permission In App Settings"),
                          dismissButton: .default(Text("Goto Settings")) {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    })
                }
            
            VStack {
                Spacer()
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
                .padding(.trailing, 10)
                .padding(.bottom, 30)
            }
        }
    }
}
