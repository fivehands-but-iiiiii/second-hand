//
//  CategoriStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/08.
//

import UIKit

class CategoriStackView: UIStackView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
