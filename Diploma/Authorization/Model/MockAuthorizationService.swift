import Foundation

enum AuthorizationError: Error {
    case notCorrectEmail
    case notCorrectPassword
    case notCorrectCourse
    case notCorrectDepartment
    case notCorrectFirstName
    case notCorrectLastName
    case notCorrectMiddleName
}

class MockAuthorizationService: AuthorizationServiceProtocol {
    private let wordsAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    private func randomString() -> String {
        return String( (0..<20).map({ _ in
            wordsAndNumbers.randomElement()!
        }))
    }
    
    func login(request: RequestLogin) async throws -> ResponseAuthorization? {
        guard !request.email.isEmpty && request.email.contains("@") else { throw AuthorizationError.notCorrectEmail }
        guard !request.password.isEmpty else { throw AuthorizationError.notCorrectPassword }
  
        return ResponseAuthorization(token: self.randomString(), role: "USER")
    }
    
    func registration(request: RequestRegistration) async throws -> ResponseAuthorization? {
        guard !request.email.isEmpty && request.email.contains("@") else { throw AuthorizationError.notCorrectEmail }
        guard !request.password.isEmpty else { throw AuthorizationError.notCorrectPassword }
        guard (1...4).contains(request.course) else { throw AuthorizationError.notCorrectCourse }
        guard !request.firstname.isEmpty else { throw AuthorizationError.notCorrectFirstName }
        guard !request.lastname.isEmpty else { throw AuthorizationError.notCorrectLastName }
        guard !request.middlename.isEmpty else { throw AuthorizationError.notCorrectMiddleName }
        guard !request.department.isEmpty else { throw AuthorizationError.notCorrectDepartment }

        return ResponseAuthorization(token: self.randomString(), role: "USER")
    }
    
    func checkEmail(email: String) async throws -> Bool? {
        guard !email.isEmpty && email.contains("@") else { throw AuthorizationError.notCorrectEmail }
        
        
        return Bool.random()
    }
}
