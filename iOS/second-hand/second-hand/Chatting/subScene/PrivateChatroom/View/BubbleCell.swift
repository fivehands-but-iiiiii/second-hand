//
//  TableViewCell.swift
//  second-hand
//
//  Created by SONG on 2023/08/03.
//

import UIKit

class BubbleCell: UITableViewCell {
    var textCount : Int = 0
    
    init(text: String) {
        super.init(style: .default, reuseIdentifier: nil)
        
        self.textCount = text.count
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraintsBubble()
    }
    
    private func setupUI() {

    }
    
    func setConstraintsBubble() {

    }
    
}

extension BubbleCell: BubbleDelegate {
    func textBoxSizeDidChange(in bubble: Bubble) {
        if let textBox = bubble.textBox {
            let bubbleWidth = textBox.contentSize.width
            bubble.widthAnchor.constraint(equalToConstant: bubbleWidth).isActive = true
        }
    }
}
