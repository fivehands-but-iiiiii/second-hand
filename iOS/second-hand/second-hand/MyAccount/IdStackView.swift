//
//  IdStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit

class IdStackView: UIStackView {
    let idLabel = UILabel()
    let idTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("필수생성자")
    }
}
