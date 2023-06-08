//
//  HomeRightBarButton.swift
//  second-hand
//
//  Created by SONG on 2023/06/07.
//

import UIKit

class HomeRightBarButton: UIBarButtonItem {

    override init() {
        super.init()
        setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfiguration()
    }
    
    private func setConfiguration() {
        self.image = UIImage(named: "threeLines.png")
        self.style = .plain
        self.target = self
        self.action = #selector(buttonTouched)
        self.tintColor = .black
    }
    
    @objc private func buttonTouched() {
    }
}
