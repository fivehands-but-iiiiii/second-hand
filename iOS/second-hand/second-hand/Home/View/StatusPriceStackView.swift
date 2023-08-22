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
        setLayout()
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
    
}
