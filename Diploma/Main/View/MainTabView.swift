import SwiftUI
import MapKit

struct MainTabView: View {
    @State var selectedTab = "Мероприятия"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    let tabsTitle = ["Мероприятия", "Карта", "Профиль"]
    let tabsImage = ["calendar", "map", "person"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            if selectedTab == "Мероприятия" {
                EventView()
            }
           
            if selectedTab == "Карта" {
                MainMapView()
            }
            
            if selectedTab == "Профиль" {
                ProfileView()
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
