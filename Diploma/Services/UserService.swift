import Foundation
import Alamofire
import KeychainSwift

struct ResponseImage: Codable {
    var imageData: Data
}

protocol UserServiceProtocol {
    func getUser() async throws -> ResponseUser?
    func getUserEventsAttend() async throws -> [ResponseEvent]?
    func updateUser(request: UserRequest) async throws -> Bool?
    func updateAvatar(image: Data) async throws -> Bool?
    func getAvatar() async throws -> ResponseImage?
    func initializerUser() async throws -> (ResponseUser?, ResponseImage?, [ResponseEvent]?)
}

final class UserService: UserServiceProtocol {
    private let baseUrl = "http://localhost:8080/api/v1/user"
    
    func initializerUser() async throws -> (ResponseUser?, ResponseImage?, [ResponseEvent]?) {
        
        async let getUser = try await getUser()
        async let getAvatar = try await getAvatar()
        async let getEvents = try await getUserEventsAttend()
         
        let (data1, data2, data3) = try await (getUser, getAvatar, getEvents)
        
        return (data1, data2, data3)
    }
    
    func getUser() async throws -> ResponseUser? {
        guard let url = URL(string: self.baseUrl + "/") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let data = AF.request(url,
                              method: .get,
                              headers: headers)
            .serializingDecodable(ResponseUser.self)
        
        return try await data.value
    }
    
    func getUserEventsAttend() async throws -> [ResponseEvent]? {
        guard let url = URL(string: self.baseUrl + "/getEventsAttended") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }

        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]

        let data = AF.request(url,
                              method: .get,
                              headers: headers)
            .serializingDecodable([ResponseEvent].self)
        
        return try await data.value
    }
    
    func updateUser(request: UserRequest) async throws -> Bool? {
        guard let url = URL(string: self.baseUrl + "/updateUser") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }

        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]

        let data = AF.request(url,
                              method: .put,
                              parameters: request,
                              encoder: JSONParameterEncoder.default,
                              headers: headers)
            .serializingDecodable(Bool.self)
  
        return try await data.value
    }
    
    func updateAvatar(image: Data) async throws -> Bool? {
        guard let url = URL(string: self.baseUrl + "/upload") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }

        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let data = AF.upload(multipartFormData: { file in
            file.append(image, withName: "image", fileName: "image.png", mimeType: "image/png")
        }, to: url, headers: headers)
            .serializingDecodable(Bool.self)
        
        return try await data.value
    }

    func getAvatar() async throws -> ResponseImage? {
        guard let url = URL(string: self.baseUrl + "/avatar") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }

        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .contentType("image/png")
        ]
        
        let data = AF.request(url,
                              method: .get,
                              headers: headers)
            .serializingDecodable(ResponseImage.self)
        
        return try await data.value
    }
}
