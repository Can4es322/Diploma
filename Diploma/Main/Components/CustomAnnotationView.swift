import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D, textAb: String) {
        self.coordinate = coordinate
    }
}

class CustomAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let image: UIImage = {
            guard let image = UIImage(systemName: "map.fill") else { return UIImage() }
            image.withRenderingMode(.alwaysTemplate)
            return image
        }()
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(imageView)
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 42, height: 42))
        self.backgroundColor = .white
        
        self.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.bounds.width / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
