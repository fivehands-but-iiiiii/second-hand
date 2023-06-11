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
        // TODO: 테이블뷰 만들어서 해야하나? over어쩌구 메소드? 알아보기
    }
 
    private func setMenuItem() -> [UIAction] {
        // TODO: 하드코딩 부분.. api연동이전엔 적어도 모델에서 뽑아오는 방식으로 변경예정
        return [
            UIAction(title: "역삼1동", handler: { _ in }),
            UIAction(title: "동네를 설정하세요", handler: { _ in })
        ]
    }
    
    
    @objc private func customButtonTapped() {
        
    }
    
}
