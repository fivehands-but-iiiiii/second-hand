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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setsetLikeButtonConstraints()
        setPriceLabelConstraints()
        setChattingRoomButtonConstraints()
    }
    func setLikeButton(isLike: Bool) {
        
    }
    
    private func setsetLikeButtonConstraints() {
        
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
