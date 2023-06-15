//
//  MyAccountLoginedViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//

import UIKit

class LoginMyAccountViewController: NavigationUnderLineViewController {
    let label = UILabel(frame: CGRect(x: 300, y: 300, width: 50, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "로그인이 된 내계정 화면임 !!"
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
    }
    

}
