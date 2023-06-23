//
//  RegisterProductScrollVeiw.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import UIKit

final class RegisterProductScrollVeiw: UIScrollView {
    private let productView = UIImageView.makeSquare(width: 80, height: 80, radius: 12, image: UIImage(systemName: "photo") ?? UIImage())
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackView()
        stackView.spacing = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStackView() {
        stackView.addArrangedSubview(productView)
    }
    
    private func configure() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        //스크롤바 가리기
        self.showsHorizontalScrollIndicator = false
    }
}

