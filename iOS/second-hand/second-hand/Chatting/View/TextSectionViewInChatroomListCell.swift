//
//  TextSectionVIewInChatroomListCell.swift
//  second-hand
//
//  Created by SONG on 2023/08/14.
//

import UIKit

class TextSectionViewInChatroomListCell: UIView {
    private var opponentIdLabel : UILabel? = nil
    private var timeLabel : UILabel? = nil
    private var lastMessage : UILabel? = nil
    
    init(opponeneId: String, time: String, lastMessage: String) {
        super.init(frame: .zero)
        setOpponentIdLabel(opponeneId)
        setTimeLabel(time)
        setLastMessage(lastMessage)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setConstraintsOpponentIdLabel()
        setConstraintsTimeLabel()
        setConstraintsLastMessage()
    }
    
    //MARK: commonInit
    
    private func setOpponentIdLabel(_ Id: String) {
        self.opponentIdLabel = UILabel(frame: .zero)
        self.opponentIdLabel?.text = Id
        self.opponentIdLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    private func setTimeLabel(_ time: String) {
        self.timeLabel = UILabel(frame: .zero)
        self.timeLabel?.text = time.convertToRelativeTime()
        self.timeLabel?.font = .systemFont(ofSize: 17.0)
        self.timeLabel?.textColor = .neutralOveray
    }
    
    private func setLastMessage(_ text: String) {
        self.lastMessage = UILabel(frame: .zero)
        self.lastMessage?.text = text
        self.lastMessage?.font = .systemFont(ofSize: 17.0)
        self.lastMessage?.numberOfLines = 1
    }
    
    //MARK: layout
    
    private func setConstraintsOpponentIdLabel() {
        guard let opponentIdLabel = opponentIdLabel else {
            return
        }
        
        if !self.contains(opponentIdLabel) {
            self.addSubview(opponentIdLabel)
        }
        
        opponentIdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                opponentIdLabel.topAnchor.constraint(equalTo: self.topAnchor),
                opponentIdLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                opponentIdLabel.widthAnchor.constraint(equalToConstant: opponentIdLabel.intrinsicContentSize.width),
                opponentIdLabel.heightAnchor.constraint(equalToConstant: opponentIdLabel.intrinsicContentSize.height)
            ]
        )
    }
    
    private func setConstraintsTimeLabel() {
        guard let timeLabel = timeLabel else {
            return
        }
        guard let opponentIdLabel = opponentIdLabel else {
            return
        }
        
        if !self.contains(timeLabel) {
            self.addSubview(timeLabel)
        }
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
                timeLabel.leadingAnchor.constraint(equalTo: opponentIdLabel.trailingAnchor,constant: 5.0),
                timeLabel.widthAnchor.constraint(equalToConstant: timeLabel.intrinsicContentSize.width),
                timeLabel.heightAnchor.constraint(equalToConstant: timeLabel.intrinsicContentSize.height)
            ]
        )
    }
    
    private func setConstraintsLastMessage(){
        guard let lastMessage = lastMessage else {
            return
        }
        
        if !self.contains(lastMessage) {
            self.addSubview(lastMessage)
        }
        
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                lastMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                lastMessage.widthAnchor.constraint(equalTo: self.widthAnchor),
                lastMessage.heightAnchor.constraint(equalToConstant: lastMessage.intrinsicContentSize.height)
            ]
        )
    }
}
