//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    let idStackView = IdStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "내 계정"
        layout()
    }
    
    func layout() {
        self.view.addSubview(idStackView)

        idStackView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            idStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            idStackView.heightAnchor.constraint(equalToConstant: 44),
            idStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
        ])
    }
}
