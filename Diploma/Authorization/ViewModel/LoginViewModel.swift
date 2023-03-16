import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginText = ""
    @Published var isErrorLogin: Bool? = nil
    @Published var passwordText = ""


    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty
    }
    
    func checkIsCorrectEmail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isErrorLogin = self.loginText.contains("@")
        }
    }
}
