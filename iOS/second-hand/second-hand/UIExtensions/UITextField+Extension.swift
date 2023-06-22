//
//  UITextField+Extension.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//


import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
