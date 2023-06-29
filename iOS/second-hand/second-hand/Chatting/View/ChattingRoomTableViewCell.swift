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
    let commponentStackView = UIStackView.setHorizontalStackViewConfig(spacing: 8)

    override func awakeFromNib() {
        super.awakeFromNib()
        setComponentStackView()
        layout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setComponentStackView() {
        addSubview(userImage)
    }
    
    private func layout() {
        [textStackView, userImage, itemImage].forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
    }

}
