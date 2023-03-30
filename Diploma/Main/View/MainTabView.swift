import SwiftUI
import MapKit

struct MainTabView: View {
    let token: String
    let role: Role
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    private var tabsTitle: [String] = []
    private var tabsImage: [String] = []
    
    @StateObject private var viewModel = MapViewModel()
    @State private var selectedTab = "Мероприятия"
    
    init(token: String, role: Role) {
        self.token = token
        self.role = role
        if role == .admin {
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
                    .environmentObject(viewModel)
            case tabsTitle[2]:
                if role == .admin {
                    StatisticView()
                } else {
                    ProfileView()
                }
            default:
                EventView()
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
        .edgesIgnoringSafeArea(.bottom)
    }
}
