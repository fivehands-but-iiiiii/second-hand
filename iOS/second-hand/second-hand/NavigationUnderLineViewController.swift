//
//  NavigationUnderLineViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/09.
//

import UIKit

class NavigationUnderLineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setNavigationBarBottomBorder()
    }
    
    private func setNavigationBarBottomBorder() {
        let borderView = UIView(frame: CGRect(x: .zero, y: navigationController?.navigationBar.frame.height ?? .zero, width: navigationController?.navigationBar.frame.width ?? .zero, height: 1))
        borderView.backgroundColor = .lightGray
        navigationController?.navigationBar.addSubview(borderView)
        
        navigationFontSetting()
    }
    
    private func navigationFontSetting() {
        let naviattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = naviattributes
    }
}
