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
    
    }
    */

}
