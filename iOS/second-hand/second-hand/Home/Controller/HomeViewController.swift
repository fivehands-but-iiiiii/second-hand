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
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
        setNavigationBarBottomBorder()
    }
    
    private func setNavigationRightBarButton() {
        let rightBarButton = HomeRightBarButton()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    
    private func setNavigationLeftBarButton() {
        let leftBarButton = HomeLeftBarButton()
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftBarButton
    }
    
    func setNavigationBarBottomBorder() {
            let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
            borderView.backgroundColor = .lightGray
            navigationController?.navigationBar.addSubview(borderView)
        }
    
}


