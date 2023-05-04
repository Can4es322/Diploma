import SwiftUI
import Combine
import KeychainSwift

struct StartView: View {
    @State var authData = ResponseAuthorization(token: "", role: "")
    @State var nextView = false
    
    var body: some View {
        NavigationView {
            if !authData.token.isEmpty && nextView{
                MainTabView(role: authData.role)
            } else {
                AuthorizationView(authData: $authData)
            }
        }
        .onReceive(Just(authData)) { newValue in
            if !authData.token.isEmpty {
                KeychainSwift().set(authData.token, forKey: "token")
                UserDefaults.standard.set(authData.role, forKey: "role")
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    nextView = true
                }
            }
        }
        .onAppear() {
            
        }
    }
}
