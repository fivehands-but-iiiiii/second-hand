//
//  HomeRightBarButton.swift
//  second-hand
//
//  Created by SONG on 2023/06/07.
//

import UIKit

protocol HomeRightBarButtonTapped {
    func homeRightBarButtonTapped()
}

final class HomeRightBarButton: UIBarButtonItem {
    var delegate: HomeRightBarButtonTapped?

    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        self.image = UIImage(named: "threeLines.png")
        self.style = .plain
        self.target = self
        self.action = #selector(buttonTouched)
        self.tintColor = .black
    }
    
    @objc private func buttonTouched() {
        delegate?.homeRightBarButtonTapped()
    }
}
