//
//  SaleLogViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SaleLogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBarBottomBorder()
    }
    
    func setNavigationBarBottomBorder() {
            let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
            borderView.backgroundColor = .lightGray
            navigationController?.navigationBar.addSubview(borderView)
        }
}
