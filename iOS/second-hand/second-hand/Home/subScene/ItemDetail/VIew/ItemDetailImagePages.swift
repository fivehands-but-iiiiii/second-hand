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

//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(systemName: "paperplane")
//        scrollView.addSubview(imageView)
        
        pageControl.numberOfPages = 2
        pageControl.backgroundColor = .clear
        pageControl.backgroundStyle = .automatic
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }

    override func layoutSubviews() {
        super.layoutSubviews()
            setConstraintsPageControl()
        }
        
        private func setConstraintsPageControl() {
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: round(self.frame.height * 44/491)),
                pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }

}
