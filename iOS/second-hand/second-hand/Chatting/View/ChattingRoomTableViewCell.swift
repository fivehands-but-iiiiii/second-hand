//
//  ChattingTableViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/30.
//

import UIKit

class ChattingRoomTableViewCell: UITableViewCell {
    
    static let identifier = "ChattingRoomCell"
    let textStackView = ChattingRoomTextStackView()
    var userImage = UIImageView()
    //let itemImage = ChattingRoomItemImageStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTextStackView()
        userImage = UIImageView(image: UIImage(systemName: "person"))
        userImage.tintColor = .black
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setTextStackView() {
        
    }
    
    
    private func layout() {
        [textStackView, userImage].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textStackView.heightAnchor.constraint(equalToConstant: 42),
            textStackView.widthAnchor.constraint(equalToConstant: 221),
            textStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            userImage.heightAnchor.constraint(equalToConstant: 48),
            userImage.widthAnchor.constraint(equalToConstant: 48),
            userImage.trailingAnchor.constraint(equalTo: textStackView.leadingAnchor, constant: -8),
            userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

