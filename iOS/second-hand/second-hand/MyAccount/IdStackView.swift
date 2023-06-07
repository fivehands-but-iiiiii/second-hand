//
//  IdStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit

class IdStackView: UIStackView {
    let idLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("필수생성자")
    }
    
    func setUI() {
        idLabel.text = "아이디"
    }
    
    func layout() {
        
        self.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.heightAnchor.constraint(equalToConstant: 22),
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            idLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)

        ])
    }
    
}
