import SwiftUI
import Foundation

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()
    
    func loadImage(for urlString: String) {
         guard let url = URL(string: urlString) else { return }
         
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data else { return }
             DispatchQueue.main.async {
                 self.image = UIImage(data: data) ?? UIImage()
             }
         }
         task.resume()
     }
}
