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


}
