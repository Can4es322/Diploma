import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var loginText = "@"
    @Published var isErrorLogin: Bool? = nil
    @Published var passwordText = "@"
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty
    }

    func checkIsCorrectEmail() {
        self.isErrorLogin = self.loginText.contains("@")
    }
    
    func loginUser() async -> AuthorizationData {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await MainActor.run {
            checkIsCorrectEmail()
        }
        
        if isErrorLogin == true {
            if loginText == "Admin@" && passwordText == "admin" {
                return AuthorizationData(token: "token", role: .admin)
            } else {
                return AuthorizationData(token: "token", role: .person)
            }
        }
        
        return AuthorizationData(token: "", role: .none)
    }
}
