//
//  TableViewCellInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class MyCell: UITableViewCell {
    static let identifier = "MYCELL"
    
    private var bubble : MyBubble? = nil
    
    init(text:String) {
        super.init(style: .default, reuseIdentifier: MyCell.identifier)
        self.bubble = MyBubble(text: text)
        bubble?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setConstraintsBubble()
    }
    
    private func setConstraintsBubble() {
        guard let bubble = bubble else {
            return
        }
        
        if !self.contentView.subviews.contains(bubble) {
            self.contentView.addSubview(bubble)
        }
        bubble.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                bubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5.0),
                bubble.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                bubble.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
                bubble.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
            ]
        )
    }
    
    private func adjustBubbleLayoutToFitTextBox() {
        guard let bubble = bubble, let textBox = bubble.textBox else {
            return
        }
        
        let bubbleWidth = textBox.frame.width + 16
        
        bubble.widthAnchor.constraint(equalToConstant: bubbleWidth).isActive = true
    }
}


extension MyCell : MyBubbleDelegate {
    func textBoxSizeDidChange(in bubble: MyBubble) {
        if let textBox = bubble.textBox {
            let bubbleWidth = textBox.contentSize.width
            
            bubble.widthAnchor.constraint(equalToConstant: bubbleWidth).isActive = true
        }
    }
    
    
}
