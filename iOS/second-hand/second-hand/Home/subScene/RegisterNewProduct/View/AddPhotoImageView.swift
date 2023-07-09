//
//  AddPhotoImageView.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/09.
//

import UIKit

final class AddPhotoImageView: UIImageView {
    
    private let cancelButton = UIButton.makeCircle(size: 28, title: "X", BackgroundColor: .black)
    
    private let titlePhotoLabel = UILabel()
    
    convenience init(image: UIImage) {
        self.init()
        setTitlePhotoLabel()
        setUI()
    }
    
    private func setTitlePhotoLabel() {
        titlePhotoLabel.backgroundColor = .neutralOveray
        titlePhotoLabel.textColor = .neutralBackground
        titlePhotoLabel.font = .systemFont(ofSize: 11)
    }
    
    private func setUI() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    private func layout() {
        [cancelButton, titlePhotoLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: -6),
            
        ])
    }
    
    

}
