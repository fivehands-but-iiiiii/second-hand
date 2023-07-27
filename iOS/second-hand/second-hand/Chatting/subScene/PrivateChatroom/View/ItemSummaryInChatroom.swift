//
//  ItemSummaryInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/25.
//

import UIKit

class ItemSummaryInChatroom: UIView {
    private var itemImage : UIImageView? = nil
    private var titleLabel : UILabel? = nil
    private var priceLabel : UILabel? = nil
    
    init(url: String, title: String, price: Int) {
        super.init(frame: .zero)
        setBorder()
        setItemImage(url: url)
        setTitleLabel(text: title)
        setPriceLabel(text: price)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraintsItemImage()
        setConstraintsTitleLabel()
        setConstraintsPriceLabel()
        setCornerRadiusItemImage()
    }
    
    private func setBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.8
    }
    
    private func setItemImage(url: String) {
        self.itemImage = UIImageView(frame: .zero)
        self.itemImage?.layer.borderColor = UIColor.lightGray.cgColor
        self.itemImage?.layer.borderWidth = 0.8
        self.itemImage?.setImage(from: url)
    }
    
    private func setTitleLabel(text: String) {
        self.titleLabel = UILabel(frame: .zero)
        self.titleLabel?.text = text
        self.titleLabel?.font = .systemFont(ofSize: 20.0)
    }
    
    private func setPriceLabel(text: Int) {
        let price = text.convertToMonetary()
        self.priceLabel = UILabel(frame: .zero)
        self.priceLabel?.text = price + "원"
        self.priceLabel?.font = .systemFont(ofSize: 20.0,weight: .bold)
    }
    
    private func setConstraintsItemImage() {
        guard let itemImage = itemImage else {
            return
        }
        
        if !self.subviews.contains(itemImage) {
            self.addSubview(itemImage)
        }

        self.itemImage?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                itemImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                itemImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
                itemImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0),
                itemImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0),
                itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor)
                
            ]
        )
    }
    
    private func setCornerRadiusItemImage(){
        layoutIfNeeded()
        self.itemImage?.layer.cornerRadius = (self.itemImage?.frame.width)! / 4
        self.itemImage?.clipsToBounds = true
    }
    
    private func setConstraintsTitleLabel() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        guard let text = titleLabel.text else {
            return
        }
        
        guard let itemImage = itemImage else {
            return
        }
        
        if !self.subviews.contains(titleLabel) {
            self.addSubview(titleLabel)
        }
        
        let width: CGFloat = CGFloat(text.count * 20)
        
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                titleLabel.widthAnchor.constraint(equalToConstant: width),
                titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor,constant: -5.0),
                titleLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
                titleLabel.heightAnchor.constraint(equalToConstant: 20.0)
                
            ]
        )
    }
    
    private func setConstraintsPriceLabel() {
        guard let priceLabel = priceLabel else {
            return
        }
        
        guard let text = priceLabel.text else {
            return
        }
        
        guard let itemImage = itemImage else {
            return
        }
        
        if !self.subviews.contains(priceLabel) {
            self.addSubview(priceLabel)
        }
        
        let width: CGFloat = CGFloat(text.count * 16)
        
        self.priceLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                priceLabel.widthAnchor.constraint(equalToConstant: width),
                priceLabel.topAnchor.constraint(equalTo: self.centerYAnchor,constant: 5.0),
                priceLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
                priceLabel.heightAnchor.constraint(equalToConstant: 20.0)
                
            ]
        )
    }
}
