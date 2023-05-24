import Foundation
import Alamofire
import KeychainSwift

protocol MapServiceProtocol {
    func getCoordinateEvents() async throws -> [ResponseEvent]?
}

final class MapService: MapServiceProtocol {
    private var baseUrl = "http://localhost:8080/api/v1/event"
    
    func getCoordinateEvents() async throws -> [ResponseEvent]? {
        guard let url = URL(string: self.baseUrl + "/getCoordinate") else { return [] }
        guard let token = KeychainSwift().get("token") else { return [] }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let data = AF.request(url,
                              method: .get,
                              headers: headers)
            .serializingDecodable([ResponseEvent].self)
        
        return try await data.value
    }
}
