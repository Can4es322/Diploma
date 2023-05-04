import Foundation
import Alamofire

protocol AuthorizationServiceProtocol {
    func login(request: RequestLogin) async throws -> ResponseAuthorization?
    func registration(request: RequestRegistration) async throws -> ResponseAuthorization?
    func checkEmail(email: String) async throws -> Bool?
}

final class AuthorizationService: AuthorizationServiceProtocol {
    private var baseUrl = "http://localhost:8080/api/v1/authorization"
    
    func login(request: RequestLogin) async throws -> ResponseAuthorization? {
        guard let url = URL(string: self.baseUrl + "/login") else { return nil }
        
        let data = AF.request(url,
                              method: .post,
                              parameters: request,
                              encoder: JSONParameterEncoder.default)
            .serializingDecodable(ResponseAuthorization.self)
        
        return try await data.value
    }
    
    func registration(request: RequestRegistration) async throws -> ResponseAuthorization? {
        guard let url = URL(string: self.baseUrl + "/register") else { return nil }
        
        let data = AF.request(url,
                              method: .post,
                              parameters: request,
                              encoder: JSONParameterEncoder.default)
            .serializingDecodable(ResponseAuthorization.self)
        
        return try await data.value
    }
    
    func checkEmail(email: String) async throws -> Bool? {
        guard let url = URL(string: self.baseUrl + "/correctEmail") else { return nil }
        
        let parameters: Parameters = [
            "email": email
        ]
        
        let data = AF.request(url,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding(destination: .queryString))
            .serializingDecodable(Bool.self)
        
        return try await data.value
    }
}
