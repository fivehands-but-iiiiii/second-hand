//
//  UIButton+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import UIKit

extension UIButton {
    static func makeSquare(width: CGFloat, height: CGFloat, radius: CGFloat) -> UIButton {
        let button = UIButton()
        button.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = radius
        button.clipsToBounds = true
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height),
        ])
        return button
    }
    
    static func makeCircle(size: CGFloat, title: String, BackgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = size/2
        button.clipsToBounds = true
        button.backgroundColor = BackgroundColor
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size),
        ])
        return button
    }
    
    func setImage(from url: String) {
        
        let cacheKey = NSString(string: url)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.setImage(cachedImage, for: .normal)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        NetworkManager.sendGETImage(fromURL: imageURL) { result in
            switch result {
            case .success(let image):
                self.setImage(image, for: .normal)
                ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
