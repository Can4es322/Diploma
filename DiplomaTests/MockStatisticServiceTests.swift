import XCTest
@testable import Diploma

final class MockStatisticServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }

    func test_mockStatisticService_getStatistic_success() async throws {
        let service = MockStatisticService()
        
        let response = try await service.getStatistic(startDate: Date(), endDate: Date())
        
        XCTAssertTrue(response != nil)
    }
}
