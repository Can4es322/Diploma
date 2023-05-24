import XCTest
@testable import Diploma

final class MockMapServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }

    func test_mockMapService_getCoordinate_success() async throws {
        let service = MockMapService()
        
        let response = try await service.getCoordinateEvents()
        
        XCTAssertTrue(response != nil)
    }
}
