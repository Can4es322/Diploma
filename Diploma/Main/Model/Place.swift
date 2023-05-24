import CoreLocation

struct Place: Identifiable, Equatable {

    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.place == rhs.place
    }

    static func != (lhs: Place, rhs: Place) -> Bool {
        return lhs.place != rhs.place
    }

    let id: Int
    var place: CLPlacemark?
}
