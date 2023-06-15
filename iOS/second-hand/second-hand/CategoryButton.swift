//
//  CategoriLabel.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/08.
//

import UIKit

final class CategoryButton: UIButton {

    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    convenience init(title: String) {
        self.init()
        setUI(title: title)
    }
    
    private func setUI(title: String) {
        self.setTitle(title, for: .normal)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        //contentEdgeInsets를 어떤걸로 대체할 수 있을까요?
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.caption1
    }
}
