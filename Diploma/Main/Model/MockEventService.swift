import Foundation

enum EventError: Error {
    case notCorrectTitle
    case notCorrectPage
    case notCorrectSize
    case notCorrectTags
    case notCorrectTagName
    case notCorrectRequestEvent
    case notCorrectEventId
}

class MockEventService: EventServiceProtocol {
    func unsubscribeEvent(eventId: Int) async throws -> Bool? {
        return nil
    }
    
    func signUpEvent(eventId: Int) async throws -> Bool? {
        return nil
    }
    
    private let wordsAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    private func randomString() -> String {
        return String( (0..<20).map({ _ in
                wordsAndNumbers.randomElement()!
            })
        )
    }
    
    func getEvents(page: Int, size: Int) async throws -> [ResponseEvent]? {
        guard !(page < 0) else { throw EventError.notCorrectPage}
        guard !(size < 0) else { throw EventError.notCorrectSize}
        
        let tags: [Tag] = [Tag(id: Int.random(in: 0...100), name: randomString())]
        let images: [Images] = [Images(id: Int.random(in: 0...10000), imageData: Data())]
        
        let response: [ResponseEvent] = [ResponseEvent(id: Int.random(in: 0...1000), title: randomString(), avatar: Data(), countPeopleMax: Int.random(in: 0...100), countPeople: Int.random(in: 0...100), description: randomString(), latitude: Double.random(in: 0...100), longitude: Double.random(in: 0...100), startDateTime: randomString(), endDateTime: randomString(), tags: tags, images: images)]
         
        return response
    }
    
    func getSearchEvents(title: String) async throws -> [ResponseEvent]? {
        guard !title.isEmpty else { throw EventError.notCorrectTitle}
        
        let tags: [Tag] = [Tag(id: Int.random(in: 0...100), name: randomString())]
        let images: [Images] = [Images(id: Int.random(in: 0...10000), imageData: Data())]
        
        let response: [ResponseEvent] = [ResponseEvent(id: Int.random(in: 0...1000), title: randomString(), avatar: Data(), countPeopleMax: Int.random(in: 0...100), countPeople: Int.random(in: 0...100), description: randomString(), latitude: Double.random(in: 0...100), longitude: Double.random(in: 0...100), startDateTime: randomString(), endDateTime: randomString(), tags: tags, images: images)]
         
        return response
    }
    
    func getSearchTagEvents(tags: [String]) async throws -> [ResponseEvent]? {
        guard !tags.isEmpty else { throw EventError.notCorrectTags}
        try tags.forEach { tag in
            guard !tag.isEmpty else { throw EventError.notCorrectTagName }
        }
        
        let tags: [Tag] = [Tag(id: Int.random(in: 0...100), name: randomString())]
        let images: [Images] = [Images(id: Int.random(in: 0...10000), imageData: Data())]
        
        let response: [ResponseEvent] = [ResponseEvent(id: Int.random(in: 0...1000), title: randomString(), avatar: Data(), countPeopleMax: Int.random(in: 0...100), countPeople: Int.random(in: 0...100), description: randomString(), latitude: Double.random(in: 0...100), longitude: Double.random(in: 0...100), startDateTime: randomString(), endDateTime: randomString(), tags: tags, images: images)]
         
        return response
    }
    
    func addEvent(request: EventRequest) async throws -> Int? {
        guard
            !request.title.isEmpty,
            (-90...90).contains(request.latitude),
            (-180...180).contains(request.longitude),
            !request.description.isEmpty,
            !request.endDateTime.isEmpty,
            !request.startDateTime.isEmpty,
            !(request.countPeopleMax < 0),
            !request.tags.isEmpty,
            !request.images.isEmpty
        else { throw EventError.notCorrectRequestEvent}
        
        return Int.random(in: 0...10000)
    }
    
    func updateEvent(request: EventRequest, id: Int) async throws -> Bool? {
        guard
            !request.title.isEmpty ||
            !request.avatar.isEmpty ||
            (-90...90).contains(request.latitude) ||
            (-180...180).contains(request.longitude) ||
            !request.description.isEmpty ||
            !request.endDateTime.isEmpty ||
            !request.startDateTime.isEmpty ||
            !(request.countPeopleMax < 0) ||
            !request.tags.isEmpty ||
            !request.images.isEmpty
        else { throw EventError.notCorrectRequestEvent}
        
        guard !(id < 0) else { throw EventError.notCorrectEventId}
        
        return Bool.random()
    }
}
