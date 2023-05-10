import SwiftUI

struct CustomImageDate: View {
    let imageData: Data?
    
    var body: some View {
        if let data = imageData {
            if let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}
