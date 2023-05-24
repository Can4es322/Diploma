import Foundation

struct EventRequest: Codable {
    let title: String
    let avatar: Data
    let countPeopleMax: Int
    let countPeople: Int
    let description: String
    let latitude: Double
    let longitude: Double
    let startDateTime: String
    let endDateTime: String
    let tags: [TagRequest]
    let images: [ImageRequest]
}

struct TagRequest: Codable {
    let name: String
}

struct ImageRequest: Codable {
    let imageData: Data
}
