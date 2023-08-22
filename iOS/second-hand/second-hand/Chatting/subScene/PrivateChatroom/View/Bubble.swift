//
//  Bubble.swift
//  second-hand
//
//  Created by SONG on 2023/08/03.
//
import UIKit

class Bubble: UIImageView {
    private var bubbleImage: UIImage?
    var textBox: UITextView?
    weak var delegate: BubbleDelegate?
    
    init(text: String) {
        super.init(frame: .zero)
        setTextBox(text: text)
        setConstraintsTextBox()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.image = bubbleImage
    }
    
    override func layoutSubviews() {
        setConstraintsTextBox()
        self.textBox?.sizeToFit()
        delegate?.textBoxSizeDidChange(in: self)
    }
    
    private func setTextBox(text: String) {
        self.textBox = UITextView(frame: .zero)
        
        self.textBox?.isScrollEnabled = false
        self.textBox?.isEditable = false
        self.textBox?.text = text
        self.textBox?.font = .systemFont(ofSize: 17.0)
        self.textBox?.textColor = .systemBackground
        self.textBox?.textAlignment = .center
        self.textBox?.backgroundColor = .clear
    }
    
    private func setConstraintsTextBox() {
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

protocol BubbleDelegate: AnyObject {
    func textBoxSizeDidChange(in bubble: Bubble)
}
