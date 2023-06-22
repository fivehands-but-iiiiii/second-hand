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
}
