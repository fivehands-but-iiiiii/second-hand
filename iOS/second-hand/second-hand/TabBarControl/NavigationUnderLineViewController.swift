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
    
    func setNavigationBarBottomBorder() {
        let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
        borderView.backgroundColor = .lightGray
        navigationController?.navigationBar.addSubview(borderView)
        
        navigationFontSetting()
    }
    
    func navigationFontSetting() {
        let naviattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = naviattributes
    }
}
