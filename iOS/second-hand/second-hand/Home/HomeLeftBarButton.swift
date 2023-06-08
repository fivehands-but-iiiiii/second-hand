//
//  HomeLeftBarButton.swift
//  second-hand
//
//  Created by SONG on 2023/06/07.
//

import UIKit

class HomeLeftBarButton: UIBarButtonItem {
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        self.customView = ButtonCustomView(frame: .zero)
        self.style = .plain
        self.tintColor = .black
        self.menu = UIMenu(options: .displayInline,children: setMenuItem())
        // TODO: 그냥 테이블뷰 만들어서 가자
    }
 
    private func setMenuItem() -> [UIAction] {
        return [
            UIAction(title: "역삼1동", handler: { _ in }),
            UIAction(title: "동네를 설정하세요", handler: { _ in })
        ]
    }
    
    @objc private func customButtonTapped() {
        
    }
    
}
