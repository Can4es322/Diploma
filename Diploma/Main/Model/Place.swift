import CoreLocation

struct Place: Identifiable {
    let id: Int
    let place: (Double, Double)
    let name: String
}
