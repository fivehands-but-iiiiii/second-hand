//
//  TableViewCellInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class MyCell: BubbleCell {
    static let identifier = "MYCELL"
    var bubble : MyBubble?

    override init(text: String) {
        super.init(text:text)
        self.bubble = MyBubble(text: text)
        bubble?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setConstraintsBubble() {
        guard let bubble = bubble else {
            return
        }
        
        guard let textBox = bubble.textBox else {
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
                bubble.topAnchor.constraint(equalTo: textBox.topAnchor, constant: -5.0),
                bubble.bottomAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 5.0)
            ]
        )
    }
}

