import SwiftUI

class MainViewModel: ObservableObject {
    @Published var inputSearch = ""
    @Published var activeTags: [Int] = []
    @Published var events = mockEvents
}
