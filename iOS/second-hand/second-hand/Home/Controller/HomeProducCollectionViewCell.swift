//
//  HomeProducCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/20.
//

import UIKit

class HomeProducCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let title = UILabel()
    let location = UILabel()
    let dot = UILabel()
    let registerTime = UILabel()
    let statusLabel = UILabel()
    let price = UILabel()
    let chat = UILabel()
    let wish = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
}
