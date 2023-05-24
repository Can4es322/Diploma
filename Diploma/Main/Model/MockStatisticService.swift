import Foundation

enum StatisticError: Error {
    
}

class MockStatisticService: StatisticServiceProtocol {
    private let wordsAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    private func randomString() -> String {
        return String( (0..<20).map({ _ in
            wordsAndNumbers.randomElement()!
        })
        )
    }
    
    func getStatistic(startDate: Date?, endDate: Date?) async throws -> ResponseStatistic? {
        let response = ResponseStatistic(departmentStatistics: [DepartmentStatistic(name: randomString(), countPeople: Int.random(in: 0...100))], totalPeopleCount: Int.random(in: 0...100))
        
        return response
    }
}
