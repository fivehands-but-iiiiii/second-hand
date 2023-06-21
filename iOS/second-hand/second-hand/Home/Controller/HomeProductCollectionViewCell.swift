//
//  HomeProducCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/20.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "productCell"
      let imageView = UIImageView()
      var title = UILabel()
      let location = UILabel()
      let dot = UILabel()
      let registerTime = UILabel()
      let statusLabel = UILabel()
      let price = UILabel()
      let chat = UILabel()
      let wish = UILabel()
      let line = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        //layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
}
