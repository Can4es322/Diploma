import Foundation
import SwiftUI

struct ResponseStatistic: Codable {
    let departmentStatistics: [DepartmentStatistic]
    let totalPeopleCount: Int
}

struct DepartmentStatistic: Codable {
    let name: String
    let countPeople: Int
}
