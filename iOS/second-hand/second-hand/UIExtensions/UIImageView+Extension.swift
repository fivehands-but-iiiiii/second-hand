//
//  UIImageView+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import UIKit

extension UIImageView {
    static func makeSquare(width: CGFloat, height: CGFloat, radius: CGFloat, image:UIImage) -> UIImageView {
        let view = UIImageView()
        view.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.image = image
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height),
        ])
        return view
    }
    
    func setImage(from url: String) {
        
        let cacheKey = NSString(string: url)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        NetworkManager.sendGETImage(fromURL: imageURL) { result in
            switch result {
            case .success(let image):
                self.image = image
                ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            case .failure(let error):
                print("불러오지 못한 이미지가 있습니다.")
            }
        }
    }
}
