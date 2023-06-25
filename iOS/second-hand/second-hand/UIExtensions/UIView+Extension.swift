//
//  UIView+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import UIKit

extension UIView {
    static func makeLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .neutralBorder
        NSLayoutConstraint.activate([
            line.widthAnchor.constraint(equalToConstant: 363),
            line.heightAnchor.constraint(equalToConstant: 1),
        ])
        return line
    }
}

