import SwiftUI

struct StartView: View {
    @State var isAuthUser = false
    
    var body: some View {
        NavigationView{
            if isAuthUser {
                MainTabView()
            } else {
                AuthorizationView(isAuthUser: $isAuthUser)
            }
        }
    }
}
