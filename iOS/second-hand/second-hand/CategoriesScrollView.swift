//
//  CategoriesScrollView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit

class CategoriesScrollView: UIScrollView {
    var categoriLabel = CategoriLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(categoriLabel.categoriStackView)
        self.categoriLabel.categoriStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
        
        self.addSubview(categoriLabel.categoriStackView)
        categoriLabel.categoriStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriLabel.categoriStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            categoriLabel.categoriStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            categoriLabel.categoriStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            categoriLabel.categoriStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
}
