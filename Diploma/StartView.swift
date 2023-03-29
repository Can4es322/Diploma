import SwiftUI

enum Role {
    case admin
    case person
}

struct StartView: View {
    @State var token = ""
    @State var role: Role = .admin
    
    var body: some View {
        NavigationView {
            if !token.isEmpty {
                MainTabView(token: token, role: role)
            } else {
                AuthorizationView(token: $token)
            }
        }
    }
}
