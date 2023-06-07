//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    let idStackView = IdStackView()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "내 계정"
        layout()
        setting()
    }
    
    func setting() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .orange
        self.view.layoutIfNeeded()
        loginButton.layer.cornerRadius = loginButton.layer.frame.height/2
        loginButton.layer.masksToBounds = true
    }
    
    func layout() {
        self.view.addSubview(loginButton)
        self.view.addSubview(idStackView)
      
        idStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            idStackView.heightAnchor.constraint(equalToConstant: 44),
            idStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
            loginButton.widthAnchor.constraint(equalToConstant: 361),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -204),
        ])
    }
}
