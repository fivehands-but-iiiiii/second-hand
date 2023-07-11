//
//  ChattingRoomStackView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/30.
//

import UIKit

class ChattingRoomTextStackView: UIStackView {

    var userName = UILabel()
    let lastChattingTime = UILabel()
    let nameTimeStackView = UIStackView()
    let lastChatting = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUserName()
        setLastChattingTime()
        setNameTimeStackView()
        setLastChatting()
        nameTimeStackView.addArrangedSubview(userName)
        nameTimeStackView.addArrangedSubview(lastChattingTime)
        nameTimeStackView.alignment = .leading
        nameTimeStackView.distribution = .fillProportionally
        nameTimeStackView.axis = .horizontal
        nameTimeStackView.spacing = 1
        self.addArrangedSubview(nameTimeStackView)
        self.addArrangedSubview(lastChatting)
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUserName()
        setLastChattingTime()
        setNameTimeStackView()
        setLastChatting()
    }
    
    private func setUserName() {
        userName.font = .subHead
        userName.textColor = .neutralTextStrong
        userName.text = "삼만보"
    }
    
    private func setLastChattingTime() {
        lastChattingTime.font = .footNote
        lastChattingTime.textColor = .neutralTextWeak
        lastChattingTime.text = "33분 전"
    }
    
    private func setNameTimeStackView() {
        nameTimeStackView.addArrangedSubview(userName)
        nameTimeStackView.addArrangedSubview(lastChattingTime)
    }
    
    private func setLastChatting() {
        lastChatting.font = .footNote
        lastChatting.textColor = .neutralText
        lastChatting.text = "안녕하세요 ! 궁금한점이 있어서 채팅 드립니다."
    }
}

