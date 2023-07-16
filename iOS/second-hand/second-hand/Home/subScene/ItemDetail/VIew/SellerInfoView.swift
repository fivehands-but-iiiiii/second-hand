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
        super.init(frame:.zero)
        self.sellerName = sellerName
        self.backgroundColor = .systemBackgroundWeak
        setLeftLabelProperties()
        setRightLabelProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
        setLeftLabelConstraints()
        setRightLabelConstraints()
    }
    
    func setSellerName(_ name : String) {
        self.sellerName = name
    }
    
    private func setCornerRadius() {
        let cornerRadius = min(bounds.width, bounds.height) / 3
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    // MARK: LEFT LABEL
    private func setLeftLabelProperties() {
        leftLabel.textAlignment = .left
        leftLabel.textColor = .black
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.text = "판매자 정보"
    }
    
    private func setLeftLabelConstraints() {
        if !self.subviews.contains(leftLabel) {
            addSubview(leftLabel)
        }
        
        guard let numberOfText = leftLabel.text?.count else {
            return
        }
        
        let width : CGFloat = CGFloat(numberOfText * 15)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15),
                leftLabel.widthAnchor.constraint(equalToConstant: width),
                leftLabel.heightAnchor.constraint(equalToConstant: 22.0),
                leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)

            ]
        )
    }
    
    // MARK: RIGHT LABEL
    private func setRightLabelProperties() {
        rightLabel.textAlignment = .right
        rightLabel.textColor = .black
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        rightLabel.text = sellerName
    }
    
    private func setRightLabelConstraints() {
        if !self.subviews.contains(rightLabel) {
            addSubview(rightLabel)
        }
        
        guard let numberOfText = rightLabel.text?.count else {
            return
        }
        
        let width : CGFloat = CGFloat(numberOfText * 15)
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15),
                rightLabel.widthAnchor.constraint(equalToConstant: width),
                rightLabel.heightAnchor.constraint(equalToConstant: 22.0),
                rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)

            ]
        )
    }
}
