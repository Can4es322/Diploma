import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var loginText = "@"
    @Published var passwordText = "f"
    @Published var confirmPassword = "f"
    @Published var isErrorLogin: Bool? = nil
    @Published var isPolitical = true
    @Published var namePerson = "a"
    @Published var lastnamePerson = "a"
    @Published var middlenamePerson = "a"
    @Published var isBottomSheet = false
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty || confirmPassword.isEmpty || !isPolitical
    }
    
    func checkIsCorrectEmail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isErrorLogin = self.loginText.contains("@")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isBottomSheet = self.isErrorLogin ?? false
        }
    }
    
    func checkIsEmptyPersonData() -> Bool {
        return namePerson.isEmpty || lastnamePerson.isEmpty || middlenamePerson.isEmpty
    }
}
