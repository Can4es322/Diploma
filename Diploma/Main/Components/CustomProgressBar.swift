import SwiftUI

struct CustomProgressBar: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let progressBar = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        progressBar.color = .gray
        progressBar.startAnimating()
        return progressBar
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
}
