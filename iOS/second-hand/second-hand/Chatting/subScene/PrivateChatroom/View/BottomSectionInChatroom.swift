//
//  BottomSectionInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class BottomSectionInChatroom: UIView {

    weak var delegate: ButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
