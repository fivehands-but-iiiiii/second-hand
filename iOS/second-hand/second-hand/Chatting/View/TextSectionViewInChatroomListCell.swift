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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
