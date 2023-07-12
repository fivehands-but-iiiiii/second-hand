//
//  ItemDetailPageControl.swift
//  second-hand
//
//  Created by SONG on 2023/07/10.
//

import UIKit

class ItemDetailImagePages: UIView {
    private var scrollView = UIScrollView()
    private var images: [String] = []
    private var imageView : UIImageView!
    private var pageControl = UIPageControl(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)

        setImagesURL()
        pageControl.numberOfPages = images.count
        pageControl.backgroundColor = .clear
        pageControl.backgroundStyle = .automatic
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraintsPageControl()
        setConstraintsScrollView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if superview != nil {
            setImagesURL()
            setImageViewOnScrollView()
            scrollView.addSubview(pageControl)
        }
    }
    
    private func setImagesURL() {
        images.append("paperplane")
        images.append("trash")
        images.append("checkmark")
    }
    
    private func setImageViewOnScrollView() {
        
        guard let width = superview?.frame.width else {
            return
        }
        
        guard let height = superview?.frame.height else {
            return
        }
        
        for index in 0..<images.count {
            imageView = UIImageView()
            let positionX = round(width * CGFloat(index))
            imageView.frame = CGRect(x: positionX, y: -Utils.safeAreaTopInset(), width: round(width), height: round(height / 2))
            imageView.image = UIImage(systemName: images[index])
            
            scrollView.contentSize.width = round(imageView.frame.width * (CGFloat(index) + 1.0))
            scrollView.addSubview(imageView)
        }
    }
    
    private func setConstraintsScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
                scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
                scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
    }
    
    private func setConstraintsPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: round(self.frame.height * 44/491)),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        )
    }
    
}

extension ItemDetailImagePages: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

