//
//  statusPriceStackView.swift
//  second-hand
//
//  Created by SONG on 2023/08/22.
//

import UIKit

class StatusPriceStackView: UIStackView {
    private var statusLabel = UILabel()
    private var priceLabel = UILabel()
    private var emptyView = UIView()
    
    init(status:Int, price:Int) {
        super.init(frame: .zero)
        self.spacing = 5.0
        
        setStatusLabel(status)
        setPriceLabel(price)
        setSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStatusLabel(_ status: Int) {
        switch status {
        case 1:
            statusLabel.text = " 예약중 "
            statusLabel.backgroundColor = .accentBackgroundSecondary
            statusLabel.isHidden = false
        case 2:
            statusLabel.text = " 판매완료 "
            statusLabel.backgroundColor = .gray
            statusLabel.isHidden = false
            
        default :
            statusLabel.isHidden = true
            
        }
        statusLabel.textAlignment = .justified
        statusLabel.font = .fontA
        statusLabel.textColor = .accentText
        
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 8
        
        statusLabel.sizeToFit()
    }
    
    private func setPriceLabel(_ price: Int) {
        let monetary = price.convertToMonetary()
        priceLabel.text = "\(monetary)원"
        priceLabel.font = .headLine
        priceLabel.textColor = .neutralTextStrong
        
        priceLabel.sizeToFit()
    }
    
    func updateStatusAndPrice(status:Int,price:Int) {
        setStatusLabel(status)
        setPriceLabel(price)
    }
    
    private func setSubviews() {
        if !self.contains(statusLabel) {
            self.addArrangedSubview(statusLabel)
        }
        
        if !self.contains(priceLabel) {
            self.addArrangedSubview(priceLabel)
            self.addArrangedSubview(UIView())
        }


    }
}
