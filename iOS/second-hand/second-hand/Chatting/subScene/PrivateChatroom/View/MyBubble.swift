//
//  MyBubble.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class MyBubble: UIImageView {
    private let bubbleImage = UIImage(systemName: "bubble.right.fill")?.resizableImage(withCapInsets: UIEdgeInsets(top: 4, left: 6, bottom: 6, right: 10.0), resizingMode: .stretch)
    
    var textBox : UITextView? = nil
    
    init(text:String){
        super.init(frame: .zero)
        self.image = bubbleImage
        self.tintColor = .accentBackgroundPrimary
        setTextBox(text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.image = bubbleImage
    }
    
    override func layoutSubviews() {
        setConsraintsTextBox()
    }
    
    private func setTextBox(text:String) {
        self.textBox = UITextView(frame: .zero)
        
        self.textBox?.isScrollEnabled = false
        self.textBox?.isEditable = false
        self.textBox?.text = text
        self.textBox?.font = .systemFont(ofSize: 17.0)
        self.textBox?.textColor = .systemBackground
        self.textBox?.textAlignment = .center
        self.textBox?.backgroundColor = .clear
    }
    
    private func setConsraintsTextBox() {
        guard let textBox = textBox else {
            return
        }
        
        if !self.subviews.contains(textBox) {
            self.addSubview(textBox)
        }
        
        textBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                textBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                textBox.widthAnchor.constraint(lessThanOrEqualToConstant: Utils.screenWidth() * 0.7)
            ]
        )
        
    }
}
