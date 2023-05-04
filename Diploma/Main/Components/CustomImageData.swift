import SwiftUI

struct CustomImageDate: View {
    let imageData: Data
    
    var body: some View {
        if let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        }
    }
}
