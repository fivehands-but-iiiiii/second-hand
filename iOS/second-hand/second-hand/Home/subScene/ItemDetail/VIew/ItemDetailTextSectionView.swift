//
//  ItemDetailTextSectionView.swift
//  second-hand
//
//  Created by SONG on 2023/07/15.
//

import UIKit

class ItemDetailTextSectionView: UIScrollView {
    private var sellerInfoView : SellerInfoView!
    private var statusButton : StatusButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.contentSize = CGSize(width: self.frame.width, height: self.frame.height)
        setSellerInfoConstraints()
        setStatusButtonConstraints()
    }
    
    func setSellerInfoView(sellerName: String) {
        self.sellerInfoView = SellerInfoView(sellerName: sellerName)
        setSellerInfoConstraints()
    }
    
    func setStatusButton(isMine: Bool, status: Int) {
        //TODO: 분기 하기 , 지금은 상시 표시됨 
        if isMine == true {
//            self.statusButton = StatusButton(status: status)
        }
        self.statusButton = StatusButton(status: status)
    }
    
    private func setSellerInfoConstraints() {
        guard let sellerInfoView = sellerInfoView else {
            return
        }
        
        if !self.subviews.contains(sellerInfoView) {
            self.addSubview(sellerInfoView)
        }
 
        sellerInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                sellerInfoView.topAnchor.constraint(equalTo: self.topAnchor),
                sellerInfoView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30.0),
                sellerInfoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 54/491),
                sellerInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ]
        )
    }
    
    private func setStatusButtonConstraints() {
        guard let statusButton = statusButton else {
            return
        }
        
        if !self.subviews.contains(statusButton) {
            self.addSubview(statusButton)
        }
        
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                statusButton.widthAnchor.constraint(equalToConstant: round(self.frame.width/3)),
                statusButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 54/491),
                statusButton.topAnchor.constraint(equalTo: self.sellerInfoView.bottomAnchor, constant: 20.0),
                statusButton.leadingAnchor.constraint(equalTo: self.sellerInfoView.leadingAnchor)
            ]
        )
 
    }
    
}
