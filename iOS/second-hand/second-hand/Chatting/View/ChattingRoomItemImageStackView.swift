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
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
