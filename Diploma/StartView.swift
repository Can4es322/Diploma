import SwiftUI
import Combine
import KeychainSwift

struct StartView: View {
    @State var authData = ResponseAuthorization(token: "", role: "")
    @State var isAuthorization = false
    
    var body: some View {
        NavigationView {
            if isAuthorization {
                MainTabView(isAuthorization: $isAuthorization, role: UserDefaults.standard.string(forKey: "role") ?? "")
            } else {
                AuthorizationView(authData: $authData)
            }
        }
        .onAppear() {
            isAuthorization = UserDefaults.standard.bool(forKey: "auth")
        }
        .onReceive(Just(authData)) { newValue in
            if !authData.token.isEmpty {
                UserDefaults.standard.set(authData.role, forKey: "role")
                KeychainSwift().set(authData.token, forKey: "token")
                authData.token = ""
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    isAuthorization = true
                    UserDefaults.standard.set(isAuthorization, forKey: "auth")
                }
            }
        }
    }
}
