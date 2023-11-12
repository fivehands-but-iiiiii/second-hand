//
//  UIScrollView=Extension.swift
//  second-hand
//
//  Created by SONG on 2023/11/07.
//

import UIKit

extension UIScrollView {
    func updateContentSize() {
        let height = calculateHeight(view: self)

        self.contentSize = CGSize(width: self.frame.width, height: height)
    }
    
    private func calculateHeight(view: UIView) -> CGFloat {
        var totalHeight: CGFloat = .zero

        for subview in view.subviews {
            if ((subview as? StatusButton) != nil) {
                totalHeight += subview.frame.height
            } else if ((subview as? SellerInfoView) != nil) {
                totalHeight += subview.frame.height
            } else if ((subview as? ContentOfPost) != nil) {
                totalHeight += subview.frame.height
            }
        }
        return totalHeight
    }
}
