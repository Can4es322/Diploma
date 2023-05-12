import SwiftUI
import MapKit

struct MainTabView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    private var tabsTitle: [String] = []
    private var tabsImage: [String] = []
    @StateObject private var mainViewModel = MainViewModel()
    @StateObject private var mapViewModel = MapViewModel()
    @State private var selectedTab = "Мероприятия"
    var isAuthorization: Binding<Bool>
    var role:String
   
    init(isAuthorization: Binding<Bool>,  role: String) {
        self.role = role
        self.isAuthorization = isAuthorization
        if role == "ADMIN" {
            tabsTitle = ["Мероприятия", "Карта", "Статистика"]
            tabsImage = ["calendar", "map", "doc.text"]
        } else {
            tabsTitle = ["Мероприятия", "Карта", "Профиль"]
            tabsImage = ["calendar", "map", "person"]
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            switch selectedTab {
            case tabsTitle[1]:
                MainMapView()
                    .environmentObject(mapViewModel)
                    .environmentObject(mainViewModel)
            case tabsTitle[2]:
                if role == "ADMIN" {
                    StatisticView(isAuthorization: isAuthorization, role: role)
                } else {
                    ProfileView(isAuthorization: isAuthorization, role: role)
                }
            default:
                EventView(role: role)
                    .environmentObject(mainViewModel)
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 0) {
                ForEach(Array(zip(tabsTitle.indices, tabsTitle)), id: \.0) { index, tab in
                    TabButton(image: tabsImage[index], title: tab, selectedTab: $selectedTab)
                    
                    if tab != tabsTitle.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, edges?.bottom == 0 ? 15 : edges?.bottom)
        }
        .onAppear() {
            Task {
                try await mainViewModel.getEvents()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
