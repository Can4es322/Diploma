import SwiftUI
import MapKit

struct MainMapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MainContent()
            
            if let select = viewModel.selectPlace {
                Spacer()
                AdditinalContent(select: select)
                    .padding([.horizontal, .bottom], 20)
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear() {
            Task {
                try await viewModel.getCoodinate()
            }
        }
    }
}

extension MainMapView {
    @ViewBuilder
    func MainContent() -> some View {
        Map()
            .environmentObject(viewModel)
            .edgesIgnoringSafeArea(.top)
    }
    
    @ViewBuilder
    func AdditinalContent(select: ResponseEvent) -> some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                ZStack {
                    CustomImageDate(imageData: viewModel.selectPlace?.avatar ?? Data())
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(viewModel.selectPlace?.title ?? "")
                        .customFontBold()
                    
                    Text(viewModel.selectPlace?.place ?? "")
                        .customFontMedium()
                }
            }
            .padding(.leading, 10)
            
            Spacer()
            
            NavigationLink(destination: EventPostView(infoCard: select).environmentObject(mainViewModel).edgesIgnoringSafeArea(.top)) {
                Text("Подробнее")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .frame(height: 44)
                    .background(Color("Blue"))
                    .frame(alignment: .bottom)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.6))
                .offset(y: 40)
        )
        .cornerRadius(14)
    }
}
