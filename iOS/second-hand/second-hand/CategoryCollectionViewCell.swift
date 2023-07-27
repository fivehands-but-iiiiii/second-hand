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
    
    func layout() {
        
    }
}
