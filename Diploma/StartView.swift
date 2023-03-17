import SwiftUI

struct StartView: View {
    @State var isAuthUser = false
    
    var body: some View {
        NavigationView{
            if isAuthUser {
                MainView()
            } else {
                AuthorizationView(isAuthUser: $isAuthUser)
            }
        }
    }
}
