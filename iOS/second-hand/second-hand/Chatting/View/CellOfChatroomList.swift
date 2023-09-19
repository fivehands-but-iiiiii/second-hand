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
        
        setTextSection(opponeneId: chatroomList.opponent.memberId, time: chatroomList.chatLogs.updatedAt ?? "", lastMessage: chatroomList.chatLogs.lastMessage ?? "")
        
        setNumberBadge(number: chatroomList.chatLogs.unReadCount)
        
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
        
        if number == 0 {
            self.numberBadge?.isHidden = true
        } else {
            self.numberBadge?.isHidden = false
        }
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
    
    //MARK: Layout
    
    private func setConstraintsOpponentImage() {
        guard let opponentImage = opponentImage else {
            return
        }
        
        if !self.contains(opponentImage) {
            self.addSubview(opponentImage)
        }
        
        opponentImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                opponentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20.0),
                opponentImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 48/80),
                opponentImage.widthAnchor.constraint(equalTo: opponentImage.heightAnchor),
                opponentImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                
            ]
        )
    }
    
    private func setConstraintTextSection() {
        guard let opponentImage = opponentImage else {
            return
        }
        guard let textSection = textSection else {
            return
        }
        
        if !self.contains(textSection) {
            self.addSubview(textSection)
        }
        
        textSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textSection.leadingAnchor.constraint(equalTo: opponentImage.trailingAnchor,constant: 10.0),
                textSection.heightAnchor.constraint(equalTo: opponentImage.heightAnchor),
                textSection.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 180/393),
                textSection.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                
            ]
        )
    }
    
    private func setConstraintNumberBadge() {
        guard let numberBadge = numberBadge else {
            return
        }
        guard let textSection = textSection else {
            return
        }
        
        if !self.contains(numberBadge) {
            self.addSubview(numberBadge)
        }
        
        numberBadge.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                numberBadge.leadingAnchor.constraint(equalTo: textSection.trailingAnchor,constant: 15.0),
                numberBadge.heightAnchor.constraint(equalTo: textSection.heightAnchor,multiplier: 20/48),
                numberBadge.widthAnchor.constraint(equalTo: numberBadge.heightAnchor),
                numberBadge.topAnchor.constraint(equalTo: textSection.topAnchor)
                
            ]
        )
    }
    
    private func setConstraintsItemImage() {
        guard let itemImage = itemImage else {
            return
        }
        
        if !self.contains(itemImage) {
            self.addSubview(itemImage)
        }
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                itemImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20.0),
                itemImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 48/80),
                itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor),
                itemImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                
            ]
        )
    }
    
    private func setCornerRadius(){
        layoutIfNeeded()
        
        guard let imageWidth = self.opponentImage?.frame.width else {
            return
        }
        
        guard let badgeWidth = self.numberBadge?.frame.width else {
            return
        }
        
        self.opponentImage?.layer.cornerRadius = imageWidth / 2
        self.opponentImage?.clipsToBounds = true
        
        self.itemImage?.layer.cornerRadius = imageWidth / 4
        self.itemImage?.clipsToBounds = true
        
        self.numberBadge?.layer.cornerRadius = badgeWidth / 2
        self.numberBadge?.clipsToBounds = true
        
    }
}
