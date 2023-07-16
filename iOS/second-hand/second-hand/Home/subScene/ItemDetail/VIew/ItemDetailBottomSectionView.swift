//
//  ItemDetailBottomSectionView.swift
//  second-hand
//
//  Created by SONG on 2023/07/17.
//

import UIKit

class ItemDetailBottomSectionView: UIView {
    private var likeButton : UIButton? = nil
    private var priceLabel : UILabel? = nil
    private var chattingRoomButton : UIButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setsetLikeButtonConstraints()
        setPriceLabelConstraints()
        setChattingRoomButtonConstraints()
    }
    func setLikeButton(isLike: Bool) {
        self.likeButton = UIButton(type: .system)
        
        switch isLike {
        case true:
            self.likeButton?.tintColor = .red
            self.likeButton?.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        default:
            self.likeButton?.tintColor = .black
            self.likeButton?.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func setsetLikeButtonConstraints() {
        guard let likeButton = likeButton else {
            return
        }
        
        if !self.subviews.contains(likeButton) {
            self.addSubview(likeButton)
        }
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                likeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 28/83),
                likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
                likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
                likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            ]
        )
    }
    
    func setPriceLabel(price: Int) {
        
    }
    
    private func setPriceLabelConstraints() {
        
    }
    
    func setChattingRoomButton() {
        
    }
    
    private func setChattingRoomButtonConstraints() {
        
    }
}
