//
//  ItemDetailPageControl.swift
//  second-hand
//
//  Created by SONG on 2023/07/10.
//

import UIKit

class ItemDetailImageSectionView: UIView {
    private var scrollView = UIScrollView()
    private var pageControl = UIPageControl(frame: .zero)
    private var images: [String] = []
    
    init(images: [String]) {
        super.init(frame: .zero)
        self.images = images
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        addSubview(scrollView)
        setConstraintsScrollView()
        
        pageControl.numberOfPages = images.count
        pageControl.backgroundColor = .clear
        pageControl.backgroundStyle = .automatic
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.hidesForSinglePage = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraintsPageControl()
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setImageViewOnScrollView()
        scrollView.addSubview(pageControl)
        
    }
    
    private func setimageViewConstraints(imageView: UIImageView, width: CGFloat, height: CGFloat, positionX: CGFloat) {
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: positionX),
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                imageView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
    
    private func setImageViewOnScrollView() {
        
        guard let width = superview?.frame.width else {
            return
        }
        
        guard let height = superview?.frame.height else {
            return
        }
        
        scrollView.contentSize = CGSize(width: round(width * CGFloat(images.count)), height: height/2 - Utils.safeAreaTopInset())
        
        for index in 0..<images.count {
            let imageView = UIImageView()
            
            let positionX = round(width * CGFloat(index))
            imageView.frame = CGRect(x: positionX, y: -Utils.safeAreaTopInset(), width: round(width), height: round(height / 2))
            imageView.setImage(from: images[index])
            
            scrollView.addSubview(imageView)
            imageView.contentMode = .scaleToFill
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

extension ItemDetailImageSectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.width != 0.0 {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
        
    }
}
