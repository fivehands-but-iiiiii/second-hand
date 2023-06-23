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
        
        //얘는 contentEdgeInsets가 deprecate되었다고 하고..
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        //이 부분에선 버튼을 생성할때마다 같은 configuration이 적용되어 글자수가 긴게 있다면 긴것의 엣지가 적용됨
//        self.configuration = .plain()
//        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.caption1
    }
}
