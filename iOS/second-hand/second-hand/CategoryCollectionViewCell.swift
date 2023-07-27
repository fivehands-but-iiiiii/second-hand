//
//  CategoryCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "categoryCell"
        let image = UIImageView(image: UIImage(systemName: "heart"))
        let title = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            layout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            layout()
        }
    
    private func layout() {
            [image, title].forEach{
                self.contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: self.topAnchor),
                image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                image.heightAnchor.constraint(equalToConstant: 44),
                image.widthAnchor.constraint(equalToConstant: 44),
                
                title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
                title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                ])
        }
}
