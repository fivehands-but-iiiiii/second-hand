//
//  HorizontalStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/28.
//

import UIKit
//
extension UIStackView {

    func setHorizontalStackViewConfig(spacing : CGFloat) {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = round(spacing)
    }
}
