//
//  MyBubble.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class MyBubble: UIImageView {
    private let bubbleImage = UIImage(named: "bubbleOragne.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0), resizingMode: .stretch)
    
    private var textBox = UITextView(frame: .zero)
    
    init(text:String){
        super.init(frame: .zero)
        self.image = bubbleImage
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
        self.textBox.isScrollEnabled = false
        self.textBox.isEditable = false
        self.textBox.text = text
        self.textBox.font = .systemFont(ofSize: 17.0)
        self.textBox.textColor = .systemBackground
        self.textBox.textAlignment = .right
    }
    
    private func setConsraintsTextBox() {
        self.textBox.sizeToFit()
        
        if !self.subviews.contains(textBox) {
            self.addSubview(textBox)
        }
        
    }
}
