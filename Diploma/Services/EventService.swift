import Foundation
import Alamofire
import KeychainSwift

protocol EventServiceProtocol {
    func getEvents(page: Int, size: Int) async throws -> [ResponseEvent]?
    func getSearchEvents(title: String) async throws -> [ResponseEvent]?
    func getSearchTagEvents(tags: [String]) async throws -> [ResponseEvent]?
    func addEvent(request: EventRequest) async throws -> Int?
    func updateEvent(request: EventRequest, id: Int) async throws -> Bool?
}

final class EventService: EventServiceProtocol {
    private var baseUrl = "http://localhost:8080/api/v1/event"
    
    func getEvents(page: Int, size: Int) async throws -> [ResponseEvent]? {
        guard let url = URL(string: self.baseUrl + "/getEvents") else { return [] }
        guard let token = KeychainSwift().get("token") else { return [] }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: Parameters = [
            "page": page,
            "size": size
        ]
        
        let data = AF.request(url,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding(destination: .queryString),
                              headers: headers)
            .serializingDecodable([ResponseEvent].self)
        
        return try await data.value
    }
    
    func getSearchEvents(title: String) async throws -> [ResponseEvent]? {
        guard let url = URL(string: self.baseUrl + "/search") else { return [] }
        guard let token = KeychainSwift().get("token") else { return [] }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: Parameters = [
            "title": title
        ]
        
        let data = AF.request(url,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding(destination: .queryString),
                              headers: headers)
            .serializingDecodable([ResponseEvent].self)
        
        return try await data.value
    }
    
    func getSearchTagEvents(tags: [String]) async throws -> [ResponseEvent]? {
        guard let url = URL(string: self.baseUrl + "/search/tag") else { return [] }
        guard let token = KeychainSwift().get("token") else { return [] }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        var newTags = ""

        tags.forEach { tag in
            newTags += tag
            newTags += ","
        }

        newTags.remove(at: newTags.index(before: newTags.endIndex))
        
        let parameters: Parameters = [
            "tags": newTags
        ]
        
        let data = AF.request(url,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding(destination: .queryString),
                              headers: headers)
            .serializingDecodable([ResponseEvent].self)
        
        return try await data.value
    }
    
    func addEvent(request: EventRequest) async throws -> Int? {
        guard let url = URL(string: self.baseUrl + "/add") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let data = AF.request(url,
                              method: .post,
                              parameters: request,
                              encoder: JSONParameterEncoder.default,
                              headers: headers)
            .serializingDecodable(Int.self)
        
        return try await data.value
    }
    
    func updateEvent(request: EventRequest, id: Int) async throws -> Bool? {
        guard let url = URL(string: self.baseUrl + "/update?id=\(id)") else { return nil }
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
}
