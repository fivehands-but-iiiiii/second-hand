//
//  AddPhotoScrollView.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/09.
//

import UIKit

class AddPhotoScrollView: UIScrollView {

    private var addPhotoStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPhotoStackView.spacing = 16
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addPhotoStackView.spacing = 16
        configure()
    }
    
    private func configure() {
        self.addSubview(addPhotoStackView)
        addPhotoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            addPhotoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            addPhotoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addPhotoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addPhotoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        //스크롤바 가리기
        self.showsHorizontalScrollIndicator = false
    }
    
}
