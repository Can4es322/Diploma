import SwiftUI

struct MiniPhoto: View {
    let imageData: Data
    
    var body: some View {
        CustomImageDate(imageData: imageData)
            .frame(width: 54, height: 54)
            .cornerRadius(12)
    }
}
