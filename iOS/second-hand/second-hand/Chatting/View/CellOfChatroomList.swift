//
//  CellOfChatroomList.swift
//  second-hand
//
//  Created by SONG on 2023/08/13.
//

import UIKit

class CellOfChatroomList: UITableViewCell {
    static let identifier = "CELLOFLIST"
    private var opponentImage : UIImageView? = nil
    private var textSection : TextSectionViewInChatroomListCell? = nil
    private var numberBadge : UILabel? = nil
    private var itemImage : UIImageView? = nil
    
    init(chatroomList: ChatroomList) {
        super.init(style: .default, reuseIdentifier: CellOfChatroomList.identifier)
        self.layer.borderColor = UIColor.neutralOveray.cgColor
        self.layer.borderWidth = 0.8
        
        setOpponentPhoto(img:chatroomList.opponent.profileImgUrl)
        
        setTextSection(opponeneId: chatroomList.opponent.memberId, time: chatroomList.chatLogs?.updatedAt ?? "", lastMessage: chatroomList.chatLogs?.lastMessage ?? "last Message")
        
        setNumberBadge(number: chatroomList.chatLogs?.unReadCount ?? 7)
        
        setItemPhoto(img: chatroomList.item.thumbnailImgUrl)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setConstraintsOpponentImage()
        setConstraintTextSection()
        setConstraintNumberBadge()
        setConstraintsItemImage()
        setCornerRadius()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
