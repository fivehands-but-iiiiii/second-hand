//
//  HomeProducCollectionViewCell.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/20.
//

import UIKit
protocol MoreButtonTappedDelegate {
    func moreButtonTapped(forIndexPath indexPath: IndexPath)
}

final class ProductListCollectionViewCell: UICollectionViewCell {
    static let identifier = "productCell"
    private let thumbnailImage = UIImageView()
    
    let title = UILabel()
    
    let location = UILabel()
    private let dot = UILabel()
    let registerTime = UILabel()
    
    private var statusAndPriceStackView : StatusPriceStackView? = nil
    
    let chatCount = UILabel()
    let wishCount = UILabel()
    private let chatImage = UIImageView()
    private let wishImage = UIImageView()
    private let line = UILabel()
    let moreButton = UIButton()
    var moreButtonTappedDelegate: MoreButtonTappedDelegate?
    
    override func prepareForReuse() {
            super.prepareForReuse()
            
            // 이미지 뷰에 이전 이미지를 초기화하거나 취소하는 로직 추가
        self.thumbnailImage.image = nil
            // 혹은 이미지 로딩 작업을 취소하는 코드를 추가할 수도 있습니다.
            // 예: 이미지 로딩 작업을 관리하는 객체에게 취소 요청을 보내는 등
        }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        layout()
    }
    
    func setUI(from item : SellingItem) {
        setImageView(url: item.thumbnailImageUrl)
        setTitle(item.title)
        setLocation(item.region)
        setDot()
        setRegisterTime(item.createdAt)
        if let stackView = statusAndPriceStackView {
            stackView.updateStatusAndPrice(status: item.status, price: item.price)
        } else {
            setStackView(item.status, item.price)
        }
        setLine()
    }
    
    private func setStackView(_ status : Int, _ price : Int ) {
        self.statusAndPriceStackView = StatusPriceStackView(status: status, price: price)
    }
    
    private func setImageView(url: String) {
        thumbnailImage.layer.borderWidth = 1
        thumbnailImage.layer.borderColor = .init(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        
        thumbnailImage.layer.masksToBounds = true
        thumbnailImage.layer.cornerRadius = 8
        thumbnailImage.setImage(from: url)
    }
    
    private func setTitle(_ itemTitle: String) {
        title.font = .subHead
        title.textColor = .neutralText
        title.text = itemTitle
    }
    
    private func setLocation(_ itemRegion: String) {
        location.font = .footNote
        location.textColor = .neutralTextWeak
        location.text = itemRegion
    }
    
    private func setDot() {
        dot.text = " ・ "
        dot.font = .footNote
        dot.textColor = .neutralTextWeak
    }
    
    private func setRegisterTime(_ time: String) {
        registerTime.font = .footNote
        registerTime.textColor = .neutralTextWeak
        registerTime.text = time.convertToRelativeTime()
    }
    
    private func setLine() {
        line.backgroundColor = .neutralBorder
    }
    
    func configure(title: String, price: String, location: String, registerTime: String) {
        self.title.text = title
        self.location.text = location
        self.registerTime.text = registerTime
    }
    
    func setMoreButton() {
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .neutralTextWeak
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        guard let collectionView = self.superview as? UICollectionView,
              let indexPath = collectionView.indexPath(for: self),
              let delegate = moreButtonTappedDelegate else {
            return
        }
        delegate.moreButtonTapped(forIndexPath: indexPath)
    }
    
    private func layout() {
        guard let statusAndPriceStackView = statusAndPriceStackView else {
            return
        }
        
        [thumbnailImage, title, location, dot, registerTime, line, moreButton].forEach{
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if !self.contentView.contains(statusAndPriceStackView) {
            self.contentView.addSubview(statusAndPriceStackView)
            statusAndPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = self.frame.height
        let width: CGFloat = self.frame.width
        let figmaHeight: CGFloat = 152
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            thumbnailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            thumbnailImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            thumbnailImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            thumbnailImage.widthAnchor.constraint(equalToConstant: height-32),
            
            title.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: round(15*widthRatio)),
            title.topAnchor.constraint(equalTo: thumbnailImage.topAnchor, constant: round(4*heightRatio)),
            
            location.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            location.topAnchor.constraint(equalTo: title.bottomAnchor, constant: round(4*heightRatio)),
            
            dot.leadingAnchor.constraint(equalTo: location.trailingAnchor),
            dot.topAnchor.constraint(equalTo: location.topAnchor),
            
            registerTime.leadingAnchor.constraint(equalTo: dot.trailingAnchor),
            registerTime.topAnchor.constraint(equalTo: dot.topAnchor),
            
            statusAndPriceStackView.leadingAnchor.constraint(equalTo: location.leadingAnchor),
            statusAndPriceStackView.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 4*heightRatio),
            statusAndPriceStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            moreButton.topAnchor.constraint(equalTo: title.topAnchor),
            moreButton.bottomAnchor.constraint(equalTo: title.bottomAnchor),
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            moreButton.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
}

