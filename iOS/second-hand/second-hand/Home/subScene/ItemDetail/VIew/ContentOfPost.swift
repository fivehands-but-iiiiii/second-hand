//
//  ContentOfPost.swift
//  second-hand
//
//  Created by SONG on 2023/07/16.
//

import UIKit

class ContentOfPost: UIView {
    private var titleLabel : UILabel? = nil
    private var categotyAndCreateAtLabel : UILabel? = nil
    private var descriptionView : UITextView? = nil
    private var countsLabel : UILabel? = nil

    init(title: String, category: Int, createAt:String, content: String, chatCount: Int, likeCount: Int, hits: Int) {
        super.init(frame: .zero)
        setTitleLabel(title: title)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleLabelConstraints()
    }
    // MARK: TITLE
    
    private func setTitleLabel(title: String) {
        self.titleLabel = UILabel(frame: .zero)
        self.titleLabel?.text = title
        self.titleLabel?.font = .headLine
    }
    
    private func setTitleLabelConstraints() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        guard let text = titleLabel.text else {
            return
        }
        
        if !self.subviews.contains(titleLabel) {
            self.addSubview(titleLabel)
        }
        
        let width = CGFloat(text.count * 15)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: width),
                titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
            ]
        )
    }
    
}
