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
        setCategotyAndCreateAtLabel(category: category, createAt: createAt)
        setDescriptionView(content: content)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleLabelConstraints()
        setCategotyAndCreateAtLabelConstraints()
        setDescriptionViewConstraints()
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
    
    // MARK: categotyAndCreateAtLabel
    
    private func setCategotyAndCreateAtLabel(category: Int, createAt:String) {
        
        let convertedCategory = convertCategoryIntToString(category)
        let convertedCreateAt = createAt.convertToRelativeTime()
        
        let text = convertedCategory + " • " + convertedCreateAt
        self.categotyAndCreateAtLabel = UILabel(frame: .zero)
        self.categotyAndCreateAtLabel?.text = text
        self.categotyAndCreateAtLabel?.font = .footNote
        self.categotyAndCreateAtLabel?.font = .systemFont(ofSize: 13.0)
        self.categotyAndCreateAtLabel?.textColor = .lightGray
    }
    
    private func setCategotyAndCreateAtLabelConstraints() {
        guard let categotyAndCreateAtLabel = categotyAndCreateAtLabel else {
            return
        }
        
        guard let text = categotyAndCreateAtLabel.text else {
            return
        }
        
        guard let standard = self.titleLabel?.bottomAnchor else {
            return
        }
        
        if !self.subviews.contains(categotyAndCreateAtLabel) {
            self.addSubview(categotyAndCreateAtLabel)
        }
        
        let width = CGFloat(text.count * 13)
        
        categotyAndCreateAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                categotyAndCreateAtLabel.topAnchor.constraint(equalTo: standard ,constant: 5.0),
                categotyAndCreateAtLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                categotyAndCreateAtLabel.widthAnchor.constraint(equalToConstant: width),
                categotyAndCreateAtLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
            ]
        )
    }
    
    // MARK: descriptionView
    
    private func setDescriptionView(content: String) {
        self.descriptionView = UITextView(frame: .zero)
        
        self.descriptionView?.text = content
        self.descriptionView?.font = .systemFont(ofSize: 15.0)
    }
    
    private func setDescriptionViewConstraints() {
        guard let descriptionView = descriptionView else {
            return
        }
        
        guard let text = descriptionView.text else {
            return
        }
        
        guard let standard = categotyAndCreateAtLabel?.bottomAnchor else {
            return
        }
        
        if !self.subviews.contains(descriptionView) {
            self.addSubview(descriptionView)
        }
        
        let lineCount = text.components(separatedBy: "\n").count
        
        let height = CGFloat((lineCount+(text.count / 25)) * 30)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                descriptionView.topAnchor.constraint(equalTo: standard ,constant: 10.0),
                descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor),
                descriptionView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
}

extension ContentOfPost {
    private func convertCategoryIntToString(_ num: Int) -> String{
        switch num {
        case 1 :
            return "디지털기기"
        case 2 :
            return "생활가전"
        case 3 :
            return "가구/인테리어"
        case 4 :
            return "생활/주방"
        case 5 :
            return "유아동"
        case 6 :
            return "유아도서"
        case 7 :
            return "여상의류"
        case 8 :
            return "여성잡화"
        case 9 :
            return "남성패션/잡화"
        case 10 :
            return "뷰티/미용"
        case 11 :
            return "스포츠/레저"
        case 12 :
            return "취미/게임/음반"
        case 13 :
            return "중고차"
        case 14 :
            return "티켓/교환권"
        case 15 :
            return "가공식품"
        case 16 :
            return "반려동물용품"
        case 17 :
            return "식물"
        case 18 :
            return "기타 중고물품"
        default:
            return "unknown"
        }
    }
}
