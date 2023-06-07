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
        setUI()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("필수생성자")
    }
    
    func setUI() {
        idLabel.text = "아이디"
        idTextField.placeholder = "아이디를 입력하세요"
    }
    
    func layout() {
        
        self.addSubview(idLabel)
        self.addSubview(idTextField)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.heightAnchor.constraint(equalToConstant: 22),
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            idLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 52.74),
            idTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            idTextField.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
}
