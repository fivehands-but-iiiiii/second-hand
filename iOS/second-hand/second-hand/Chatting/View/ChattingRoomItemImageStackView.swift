//
//  ChattingRoomItemImageStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/30.
//

import UIKit

class ChattingRoomItemImageStackView: UIStackView {

    let unReadChattingCount = UILabel()
    let itemImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUnReadChattingCount()
        setItemImage()
        self.addSubview(unReadChattingCount)
        self.addSubview(itemImage)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUnReadChattingCount() {
        unReadChattingCount.font = .systemFont(ofSize: 11)
        unReadChattingCount.textColor = .neutralBackground
        unReadChattingCount.text = "4"
        unReadChattingCount.backgroundColor = .accentBackgroundPrimary
    }
    
    private func setItemImage() {
        itemImage.backgroundColor = .orange
    }
    
}
