//
//  UIScrollView=Extension.swift
//  second-hand
//
//  Created by SONG on 2023/11/07.
//

import UIKit

extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)

        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero

        for subview in view.subviews {
            if ((subview as? StatusButton) != nil) {
                print("StatusButton \(subview.frame)")
                totalRect = totalRect.union(recursiveUnionInDepthFor(view: subview))
            } else if ((subview as? SellerInfoView) != nil) {
                print("SellerInfoView \(subview.frame)")
                totalRect = totalRect.union(recursiveUnionInDepthFor(view: subview))
            } else if ((subview as? ContentOfPost) != nil) {
                print("ContentOfPost \(subview.frame)")
                totalRect = totalRect.union(recursiveUnionInDepthFor(view: subview))
            }
        }
        print("한사이클 끝 \(totalRect.union(view.frame).size)")
        return totalRect.union(view.frame)
    }
}
