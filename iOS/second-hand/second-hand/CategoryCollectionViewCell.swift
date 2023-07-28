import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "categoryCell"
    let imageView = UIImageView()
    let title = UILabel()
    var imageUrl: String? {
            didSet {
                loadImage()
            }
        }
    
    override init(frame: CGRect) {
        // Provide default values for id and imageUrl properties
        
        super.init(frame: frame)
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        // Provide default values for id and imageUrl properties
        
        super.init(coder: coder)
        setUI()
        layout()
    }
    
    private func setUI() {
        title.textAlignment = .center
        title.font = .footNote
        title.textColor = .neutralText
    }
    
    private func layout() {
        [imageView, title].forEach{
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            imageView.widthAnchor.constraint(equalToConstant: 44),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func loadImage() {
            guard let urlString = self.imageUrl, let url = URL(string: urlString) else {
                imageView.image = nil
                return
            }
            
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async {
                        self.imageView.image = nil
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
}
