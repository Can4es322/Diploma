import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginText = "@"
    @Published var isErrorLogin: Bool? = nil
    @Published var passwordText = "@"
    
    init() {
        print("Login Create \(Unmanaged.passUnretained(self).toOpaque())")
    }
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty
    }
    
    func checkIsCorrectEmail(completion: @escaping ()->()) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            self?.isErrorLogin = self?.loginText.contains("@")
            completion()
        }
       
    }
    
    func registrationUser(completion: @escaping ()->()) {
        checkIsCorrectEmail() {
            DispatchQueue.main.async {
               completion()
            }
        }
    }
    deinit {
        print("Login is Dead \(Unmanaged.passUnretained(self).toOpaque())")
    }
}
