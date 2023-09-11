//
//  CategoriesScrollView.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/07.
//

import UIKit

final class CategoryScrollView: UIScrollView {

    var categoriStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoriStackView.spacing = 4
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        categoriStackView.spacing = 4
        configure()
    }
    
    private func configure() {
        self.addSubview(categoriStackView)
        categoriStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            categoriStackView.topAnchor.constraint(equalTo: self.topAnchor),
            categoriStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoriStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoriStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        //스크롤바 가리기
        self.showsHorizontalScrollIndicator = false
    }
}
