import SwiftUI

struct MiniPhoto: View {
    let photo: String
    
    var body: some View {
        CustomAsyncImage(url: photo)
            .frame(width: 54, height: 54)
            .cornerRadius(12)
    }
}
