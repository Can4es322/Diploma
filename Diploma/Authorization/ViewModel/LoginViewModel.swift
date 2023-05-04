import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var loginText = "can@gmail.com"
    @Published var isErrorLogin: Bool? = nil
    @Published var passwordText = "123"
    var responseAuthorization: ResponseAuthorization?
    let service: AuthorizationService
   
    init(service: AuthorizationService = AuthorizationService()) {
        self.service = service
    }
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty
    }

    func checkIsCorrectEmail() {
        self.isErrorLogin = self.loginText.contains("@")
    }
    
    func loginUser() async throws -> ResponseAuthorization {
        do {
            self.responseAuthorization = try await service.login(request: RequestLogin(email: self.loginText, password: self.passwordText))
            if responseAuthorization != nil {
                await MainActor.run(body: {
                    self.isErrorLogin = true
                })
            }
            
        } catch {
            await MainActor.run(body: {
                self.isErrorLogin = false
            })
        }
        
        return responseAuthorization ?? ResponseAuthorization(token: "", role: "")
    }
}
