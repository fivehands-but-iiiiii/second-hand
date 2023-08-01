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
        guard let textBox = textBox else {
            return
        }
        
        if !self.subviews.contains(textBox) {
            self.addSubview(textBox)
        }
        
    }
}
