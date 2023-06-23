//
//  ProductImage.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/23.
//

import UIKit

class ProductImage: UIImageView {
    let cancelButton = UIButton.makeCircle(size: 28, title: "X", BackgroundColor: .black)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageView()
        setcancelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageView() {
        let widthHeight: CGFloat = 80
        self.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = widthHeight/2
        self.clipsToBounds = true
        self.image = UIImage(systemName: "photo")
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: widthHeight),
            self.heightAnchor.constraint(equalToConstant: widthHeight),
        ])
    }
    
    func setcancelButton() {
        cancelButton.tintColor = .neutralBackground
        
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: -6),
        cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5)
        ])
    }
    
    
}
