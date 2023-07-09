//
//  ItemDetailPageControl.swift
//  second-hand
//
//  Created by SONG on 2023/07/10.
//

import UIKit

class ItemDetailImagePages: UIView {
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
            pageControl.numberOfPages = 2
            pageControl.backgroundColor = .blue
            pageControl.backgroundStyle = .automatic
            addSubview(pageControl)
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
