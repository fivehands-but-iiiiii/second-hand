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
}
