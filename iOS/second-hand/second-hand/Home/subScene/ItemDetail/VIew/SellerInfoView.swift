//
//  SellerInfoView.swift
//  second-hand
//
//  Created by SONG on 2023/07/15.
//

import UIKit

class SellerInfoView: UIView {
    private var sellerName: String? = nil
    private let leftLabel = UILabel(frame: .zero)
    private let rightLabel = UILabel(frame: .zero)

    init(sellerName: String) {
        super.init(frame: .zero)
        self.sellerName = sellerName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    
    
}
