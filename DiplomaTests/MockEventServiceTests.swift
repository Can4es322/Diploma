import XCTest
@testable import Diploma

final class MockEventSericeTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_mockEventService_getEvents_success() async throws {
        let service = MockEventService()
        let page = 1
        let size = 5
        
        let response = try await service.getEvents(page: page, size: size)
        
        XCTAssertTrue(response?.isEmpty != true)
    }
    
    func test_mockEventService_getEvents_failurePage() async throws {
        let service = MockEventService()
        let page = -1
        let size = 5
        
        do {
            let _ = try await service.getEvents(page: page, size: size)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectPage)
        }
    }
    
    func test_mockEventService_getEvents_failureSize() async throws {
        let service = MockEventService()
        let page = 1
        let size = -100
        
        do {
            let _ = try await service.getEvents(page: page, size: size)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectSize)
        }
    }
    
    func test_mockEventService_getSearchEvent_success() async throws {
        let service = MockEventService()
        let title = "Title"
    
        let response = try await service.getSearchEvents(title: title)
        
        XCTAssertTrue(response != nil)
    }
    
    func test_mockEventService_getSearchEvent_failureTitle() async throws {
        let service = MockEventService()
        let title = ""
        
        do {
            let _ = try await service.getSearchEvents(title: title)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectTitle)
        }
    }
    
    func test_mockEventService_getSearchTagEvents_success() async throws {
        let service = MockEventService()
        let tags: [String] = ["text"]
        
        let response = try await service.getSearchTagEvents(tags: tags)
        
        XCTAssertTrue(response != nil)
    }
    
    func test_mockEventService_getSearchTagEvents_failureTags() async throws {
        let service = MockEventService()
        let tags: [String] = []
        
        do {
            let response = try await service.getSearchTagEvents(tags: tags)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectTags)
        }
    }
    
    func test_mockEventService_getSearchTagEvents_failureTagsName() async throws {
        let service = MockEventService()
        let tags: [String] = ["", ""]
        
        do {
            let response = try await service.getSearchTagEvents(tags: tags)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectTagName)
        }
    }

    func test_mockEventService_addEvent_success() async throws {
        let service = MockEventService()
        let tags: [TagRequest] = [TagRequest(name: "text")]
        let images: [ImageRequest] = [ImageRequest(imageData: Data())]
        let request = EventRequest(title: "fd", avatar: Data(), countPeopleMax: 22, countPeople: 12, description: "f", latitude: 2, longitude: 2, startDateTime: "f", endDateTime: "f", tags: tags, images: images)
        
        
        let response = try await service.addEvent(request: request)
        
        XCTAssertTrue(response != nil )
    }
    
    func test_mockEventService_addEvent_failureRequest() async throws {
        let service = MockEventService()
        let tags: [TagRequest] = []
        let images: [ImageRequest] = []
        let request = EventRequest(title: "", avatar: Data(), countPeopleMax: 22, countPeople: 12, description: "", latitude: 2, longitude: 2, startDateTime: "", endDateTime: "", tags: tags, images: images)
        
        do {
            let response = try await service.addEvent(request: request)
            XCTFail()
        } catch let error as EventError {
            XCTAssertEqual(error, EventError.notCorrectRequestEvent)
        }
    }
    
    func test_mockEventService_updateEvent_success() async throws {
        let service = MockEventService()
        let tags: [TagRequest] = []
        let images: [ImageRequest] = []
        let request = EventRequest(title: "", avatar: Data(), countPeopleMax: 22, countPeople: 12, description: "", latitude: 2, longitude: 2, startDateTime: "", endDateTime: "", tags: tags, images: images)
        let id = 1
    
        let response = try await service.updateEvent(request: request, id: id)
        
        XCTAssertTrue(response != nil)
    }
}
