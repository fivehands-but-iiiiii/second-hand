//
//  ChattingTableViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/30.
//

import UIKit

class ChattingRoomTableViewCell: UITableViewCell {
    
    let identifier = "ChattingRoomCell"
    let textStackView = ChattingRoomTextStackView()
    let userImage = UIImageView()
    let itemImage = ChattingRoomItemImageStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
