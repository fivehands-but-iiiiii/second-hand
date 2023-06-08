//
//  CategoriLabel.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/08.
//

import UIKit

class CategoriLabel: UILabel {
    var categoriStackView = CategoriStackView()
    
    convenience init(title: String) {
        self.init(frame: .zero)
        var label = UILabel()
        label.text = title
        label.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        categoriStackView.addArrangedSubview(label)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
