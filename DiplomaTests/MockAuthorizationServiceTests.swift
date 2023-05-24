import XCTest
@testable import Diploma

final class MockAuthorizationServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_mockAuthorizationService_login_success() async throws {
        let service = MockAuthorizationService()
        let request = RequestLogin(email: "abob@agmail.com", password: "fdfgdh")
    
        let response = try await service.login(request: request)
        
        XCTAssertTrue(response?.token.isEmpty != nil)
    }
    
    func test_mockAuthorizationService_login_failureEmail() async throws {
        let service = MockAuthorizationService()
        let request = RequestLogin(email: "aboba.com", password: "fdfgdh")
    
        do {
            let _ = try await service.login(request: request)
            XCTFail()
        } catch let error as AuthorizationError {
            XCTAssertEqual(error, AuthorizationError.notCorrectEmail)
        }
    }
    
    func test_mockAuthorizationService_login_failurePassword() async throws {
        let service = MockAuthorizationService()
        let request = RequestLogin(email: "abo@ba.com", password: "")
    
        do {
            let _ = try await service.login(request: request)
            XCTFail()
        } catch let error as AuthorizationError {
            XCTAssertEqual(error, AuthorizationError.notCorrectPassword)
        }
    }
    
    func test_mockAuthorizationService_registration_success() async throws {
        let service = MockAuthorizationService()
        let request = RequestRegistration(email: "fdi@gmail.com", password: "password", firstname: "name", lastname: "lastname", middlename: "middle", department: "MOP", course: 1)
 
        let response = try await service.registration(request: request)
        
        XCTAssertTrue(response?.token.isEmpty != nil)
    }
    
    func test_mockAuthorizationService_registration_failureCourse() async throws {
        let service = MockAuthorizationService()
        let request = RequestRegistration(email: "fdi@gmail.com", password: "password", firstname: "name", lastname: "lastname", middlename: "middle", department: "MOP", course: 0)
    
        do {
            let _ = try await service.registration(request: request)
            XCTFail()
        } catch let error as AuthorizationError {
            XCTAssertEqual(error, AuthorizationError.notCorrectCourse)
        }
    }
    
    func test_mockAuthorizationService_registration_failureEmail() async throws {
        let service = MockAuthorizationService()
        let request = RequestRegistration(email: "fdimail.com", password: "password", firstname: "name", lastname: "lastname", middlename: "middle", department: "MOP", course: 0)
    
        do {
            let _ = try await service.registration(request: request)
            XCTFail()
        } catch let error as AuthorizationError {
            XCTAssertEqual(error, AuthorizationError.notCorrectEmail)
        }
    }
    
    func test_mockAuthorizationService_checkEmail_resultTrue() async throws {
        let service = MockAuthorizationService()
        let email = "aboba@gmail.com"
    
        let response = try await service.checkEmail(email: email)
        
        XCTAssertTrue(response != nil)
    }
    
    func test_mockAuthorizationService_checkEmail_resultFailure() async throws {
        let service = MockAuthorizationService()
        let email = "gmail.com"
    
        do {
            let _ = try await service.checkEmail(email: email)
            XCTFail()
        } catch let error as AuthorizationError {
            XCTAssertEqual(error, AuthorizationError.notCorrectEmail)
        }
    }
}
