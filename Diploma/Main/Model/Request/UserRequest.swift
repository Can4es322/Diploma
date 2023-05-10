import Foundation

struct UserRequest: Codable {
    let firstname: String
    let lastname: String
    let middlename: String
    let course: Int
    let department: String
    let avatar: Data
    let email: String
}
