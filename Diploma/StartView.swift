import SwiftUI

enum Role {
    case admin
    case person
    case none
}

struct AuthorizationData {
    var token: String
    var role: Role
}

struct StartView: View {
    @State var authData = AuthorizationData(token: "", role: .none)
    
    var body: some View {
        NavigationView {
            if !authData.token.isEmpty && (authData.role == .person || authData.role == .admin) {
                MainTabView(token: authData.token, role: authData.role)
            } else {
                AuthorizationView(authData: $authData)
            }
        }
    }
}
