//
//  HorizontalStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/28.
//

import UIKit
//
extension UIStackView {

    static func setHorizontalStackViewConfig(spacing : CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = round(spacing)
        return stackView
    }
}
