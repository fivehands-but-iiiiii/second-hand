//
//  NavigationUnderLineViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/09.
//

import UIKit

class NavigationUnderLineViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarBottomBorder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    private func setNavigationBarBottomBorder() {
        let borderView = UIView(frame: CGRect(x: .zero, y: navigationController?.navigationBar.frame.height ?? .zero, width: navigationController?.navigationBar.frame.width ?? .zero, height: 1))
        borderView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        navigationController?.navigationBar.addSubview(borderView)
        
        navigationFontSetting()
    }
    
    private func navigationFontSetting() {
        let naviattributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = naviattributes
    }
}
