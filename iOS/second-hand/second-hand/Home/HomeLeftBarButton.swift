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
    }
}
