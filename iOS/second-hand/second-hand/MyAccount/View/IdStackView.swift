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
    var idTextFieldDelegate: UITextFieldDelegate? {
            get {
                return idTextField.delegate
            }
            set {
                idTextField.delegate = newValue
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        setLabel()
        setTextField()
        setConstraint()
    }
    private func setLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont.body
    }
    
    private func setTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
        idTextField.font = UIFont.body
    }
    
    private func setConstraint() {
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
