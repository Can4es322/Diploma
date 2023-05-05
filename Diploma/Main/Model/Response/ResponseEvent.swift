import Foundation

struct ResponseEvent: Identifiable, Codable {
    let id: Int
    let title: String
    let avatar: Data
    let countPeopleMax: Int
    let countPeople: Int
    let description: String
    let latitude: Double
    let longitude: Double
    let startDateTime: String
    let endDateTime: String
    var tags: [Tag]
    let images: [Images]
    var place: String?
    var date: String?
}

struct Tag: Identifiable, Codable {
    let id: Int
    var name: String
    var ruName: String?
}

struct Images: Identifiable, Codable, Hashable {
    let id: Int
    let imageData: Data
}
