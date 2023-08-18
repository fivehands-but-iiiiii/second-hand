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
    
    private func setOpponentPhoto(img:String) {
        self.opponentImage = UIImageView(frame: .zero)
        opponentImage?.setImage(from: img)
    }
    
    private func setTextSection(opponeneId: String, time: String, lastMessage: String) {
        self.textSection = TextSectionViewInChatroomListCell(opponeneId: opponeneId, time: time, lastMessage: lastMessage)
    }
    
    private func setNumberBadge(number: Int) {
        self.numberBadge = UILabel(frame: .zero)
        self.numberBadge?.text = String(number)
        self.numberBadge?.backgroundColor = .accentBackgroundPrimary
        self.numberBadge?.textColor = .white
        self.numberBadge?.textAlignment = .center
    }
    
    private func setItemPhoto(img: String) {
        self.itemImage = UIImageView(frame: .zero)
        self.itemImage?.setImage(from: img)
        self.itemImage?.layer.borderColor = UIColor.neutralOveray.cgColor
        self.itemImage?.layer.borderWidth = 0.8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
