import SwiftUI
import PhotosUI
import Foundation

@available(iOS 14, *)
struct PhotoPickerImages: UIViewControllerRepresentable {
    @Binding var imagesData: EventImage
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> Coordinator {
        return PhotoPickerImages.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 5
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPickerImages
        
        init(parent: PhotoPickerImages) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.imagesData.avatar = nil
            parent.imagesData.images.removeAll()
            Array(zip(results.indices, results)).forEach { (index, image) in
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) {[weak self]  image, error in
                        guard let image = image as? UIImage else { return }
                       
                        DispatchQueue.main.async {
                            if index == 0 {
                                self?.parent.imagesData.avatar = image
                            } else {
                                self?.parent.imagesData.images.append(image)
                            }
                        }
                    }
                } else {
                    print("Error loaded image")
                }
            }
            parent.isPresented.toggle()
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
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
