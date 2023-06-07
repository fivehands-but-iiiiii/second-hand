//
//  HomeViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBarButton()
    }
    func setNavigationBarButton() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "threeLines.png"), style: .plain, target: self, action: #selector(rightButtonTouched))
        
        rightBarButton.tintColor = .black
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    
    @objc private func rightButtonTouched() {
        
    }
}

extension UIBarButtonItem.Style {
    
}
