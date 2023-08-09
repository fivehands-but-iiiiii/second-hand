//
//  YourCell.swift
//  second-hand
//
//  Created by SONG on 2023/08/03.
//

import UIKit

class YourCell: BubbleCell {
    static let identifier = "YOURCELL"
    private var bubble : YourBubble?
    
    override init(text: String) {
        super.init(text: text)
        self.bubble = YourBubble(text: text)
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
                bubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 5.0),
                bubble.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                bubble.topAnchor.constraint(equalTo: textBox.topAnchor, constant: -5.0),
                bubble.bottomAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 5.0)
            ]
        )
    }
}
