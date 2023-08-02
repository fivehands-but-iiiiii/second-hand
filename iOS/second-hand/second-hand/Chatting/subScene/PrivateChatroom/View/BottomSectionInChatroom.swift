//
//  BottomSectionInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class BottomSectionInChatroom: UIView {
    private var textField : UITextField? = nil
    private var sendButton : UIButton? = nil
    
    weak var delegate: ButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        generateTextField()
        generateSendButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        generateTextField()
        generateSendButton()
    }
    
    private func commonInit() {
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraintsTextField()
        setConstraintsSendButton()
    }
    
    private func generateTextField() {
        self.textField = UITextField(frame: .zero)
        
        self.textField?.borderStyle = .roundedRect
        self.textField?.layer.borderColor = UIColor.systemBackgroundWeak.cgColor
        self.textField?.font = .systemFont(ofSize: 15.0)
        self.textField?.placeholder = "내용을 입력하세요"
    }
    
    private func setConstraintsTextField() {
        guard let textField = textField else {
            return
        }
        
        if !self.subviews.contains(textField) {
            self.addSubview(textField)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 30/83),
                textField.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 325/393),
                textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
                textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            ]
        )
    }
    
    private func generateSendButton() {
        self.sendButton = UIButton(type: .system)

        self.sendButton?.tintColor = .accentBackgroundPrimary
        self.sendButton?.setBackgroundImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        self.sendButton?.addTarget(self, action: #selector(sendButtonTouched), for: .touchUpInside)
    }
    
    private func setConstraintsSendButton() {
        guard let sendButton = sendButton else {
            return
        }
        
        guard let textField = textField else {
            return
        }
        
        if !self.subviews.contains(sendButton) {
            self.addSubview(sendButton)
        }
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                sendButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 30/83),
                sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
                sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.5),
                sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
            ]
        )
    }
    
    @objc private func sendButtonTouched() {
        guard let text = textField?.text else {
            return
        }

        delegate?.sendButtonTouched?(message:text)
        textField?.text = ""
    }
}
