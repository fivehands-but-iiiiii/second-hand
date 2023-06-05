//
//  HomeViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class HomeViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBar()
    }
    func setNavigationBar() {
        
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .white
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "test"), style: .plain, target: self, action: #selector(rightButtonTouched))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
    @objc private func rightButtonTouched() {
        
    }
}
