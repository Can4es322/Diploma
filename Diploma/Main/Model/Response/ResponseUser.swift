import Foundation

struct ResponseUser: Codable {
    var firstname: String
    var lastname: String
    var middlename: String
    var course: Int
    var department: String
    var avatar: Data? = Data()
    var email: String
    var password: String
    var role: String
}
