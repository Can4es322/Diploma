import SwiftUI
import Foundation

class MainViewModel: ObservableObject {
    @Published var inputSearch = ""
    @Published var activeTags: [Int] = []
    @Published var events = mockEvents
    @Published var isSelectedPhotos = false
    @Published var selectedImageId = ""
    @Published var imageViewerOffset: CGSize = .zero
    @Published var bgOpacity: Double = 1
    @Published var imageScale: Double = 1
    
    func onChange(value: CGSize) async {
        await MainActor.run {
            self.imageViewerOffset = value
            
            let halgHeight = UIScreen.main.bounds.height / 2
            let progress = self.imageViewerOffset.height / halgHeight
            
            withAnimation {
                self.bgOpacity = Double(1 - progress)
            }
        }

    }
    
    func onEnd(value: DragGesture.Value) async {
        await MainActor.run {
            withAnimation(.easeInOut) {
                let translation = value.translation.height
                
                if translation < 250 {
                    self.imageViewerOffset = .zero
                    self.bgOpacity = 1
                } else {
                    self.bgOpacity = 1
                    self.isSelectedPhotos.toggle()
                    self.imageViewerOffset = .zero
                }
            }
        }
    }
}
