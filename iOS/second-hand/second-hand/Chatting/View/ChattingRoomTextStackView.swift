//
//  ChattingRoomStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/30.
//

import UIKit

class ChattingRoomTextStackView: UIStackView {

    let userName = UILabel()
    let lastChattingTime = UILabel()
    let nameTimeStackView = UIStackView.setHorizontalStackViewConfig(spacing: 1)
    let lastChatting = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUserName()
        setLastChattingTime()
        setNameTimeStackView()
        setLastChatting()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUserName() {
        
    }
    
    private func setLastChattingTime() {
        
    }
    
    private func setNameTimeStackView() {
        
    }
    
    private func setLastChatting() {
        
    }
}
