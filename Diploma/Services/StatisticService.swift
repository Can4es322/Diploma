import Foundation
import Alamofire
import KeychainSwift

protocol StatisticServiceProtocol {
    func getStatistic(startDate: Date?, endDate: Date?) async throws -> ResponseStatistic?
}

final class StatisticService: StatisticServiceProtocol {
    private var baseUrl = "http://localhost:8080/api/v1/statistic"
    
    func getStatistic(startDate: Date?, endDate: Date?) async throws -> ResponseStatistic? {
        guard let url = URL(string: self.baseUrl + "/getStatistic") else { return nil }
        guard let token = KeychainSwift().get("token") else { return nil }
        var strStartDate = ""
        var strEndDate = ""
        
        if let start = startDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd'T'HH:mm"
            strStartDate = formatter.string(from: start)
        }
        
        if let end = endDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd'T'HH:mm"
            strEndDate = formatter.string(from: end)
        }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: Parameters = [
            "startDate": strStartDate,
            "endDate": strEndDate
        ]
        
        let data = AF.request(url,
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding(destination: .queryString),
                              headers: headers)
            .serializingDecodable(ResponseStatistic.self)
        
        return try await data.value
    }
}
