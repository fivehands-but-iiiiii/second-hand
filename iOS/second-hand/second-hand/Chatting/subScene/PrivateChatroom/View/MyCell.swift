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
        
        bubble.sizeToFit()
        bubble.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                bubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5.0),
                bubble.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ]
        )
    }
}
