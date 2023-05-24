import Foundation

enum MapError: Error {
    
}

class MockMapService: MapServiceProtocol {
    
    private let wordsAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    private func randomString() -> String {
        return String( (0..<20).map({ _ in
            wordsAndNumbers.randomElement()!
        })
        )
    }
    
    func getCoordinateEvents() async throws -> [ResponseEvent]? {
        let tags: [Tag] = [Tag(id: Int.random(in: 0...100), name: randomString())]
        let images: [Images] = [Images(id: Int.random(in: 0...10000), imageData: Data())]
        let response: [ResponseEvent] = [ResponseEvent(id: Int.random(in: 0...1000), title: randomString(), avatar: Data(), countPeopleMax: Int.random(in: 0...100), countPeople: Int.random(in: 0...100), description: randomString(), latitude: Double.random(in: 0...100), longitude: Double.random(in: 0...100), startDateTime: randomString(), endDateTime: randomString(), tags: tags, images: images)]
        
        return response
    }
}
