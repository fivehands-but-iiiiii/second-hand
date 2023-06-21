//
//  HomeProducCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/20.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "productCell"
    let imageView = UIImageView()
    var title = UILabel()
    let location = UILabel()
    let dot = UILabel()
    let registerTime = UILabel()
    let statusLabel = UILabel()
    let price = UILabel()
    let chat = UILabel()
    let wish = UILabel()
    let line = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setImageView()
        setTitle()
    }
    
    private func setImageView() {
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
    }
    
    private func setTitle() {
        title.font = .subHead
        title.textColor = .neutralText
    }
    
    func layout() {
        [imageView, title, location, dot, registerTime, statusLabel, price, chat, wish, line].forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = self.frame.height
        let width: CGFloat = self.frame.width
        let figmaHeight: CGFloat = 152
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: height-32),
            
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15*widthRatio),
            title.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4*heightRatio),
            
        ])
    }
}

