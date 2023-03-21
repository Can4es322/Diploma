import SwiftUI
import PhotosUI
import Foundation

@available(iOS 14, *)
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPicker: Bool
    
    func makeCoordinator() -> Coordinator {
        return PhotoPicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPicker.toggle()
            for image in results {
                if image .itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        guard let image = image as? UIImage else { return }
                        DispatchQueue.main.async {
                            self.parent.image = image
                        }
                    }
                } else {
                    print("Error loaded image")
                }
            }
        }
    }
}


@available(iOS 13, *)
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
