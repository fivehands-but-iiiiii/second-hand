//
//  CategoriLabel.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/08.
//

import UIKit

class CategoryButton: UIButton {
    // TODO: 이 클래스는 공사가 필요할 듯 함
    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        // TODO: 이거 더이상 안쓰는 속성. 바꿔야함
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.caption1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    // TODO: layoutSubView에서 하는방법 말고 다른 방법 강구
}
