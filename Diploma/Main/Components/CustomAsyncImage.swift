import SwiftUI

struct CustomAsyncImage: View {
    let url: String
    @StateObject var imageLoader = ImageLoaderService()
    
    var body: some View {
        Image(uiImage: imageLoader.image)
            .resizable()
            .scaledToFill()
            .onAppear() {
                imageLoader.loadImage(for: url)
            }
    }
}
