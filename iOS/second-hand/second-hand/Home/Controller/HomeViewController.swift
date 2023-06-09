//
//  HomeViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class HomeViewController: NavigationUnderLineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
    }
    
    private func setNavigationRightBarButton() {
        let rightBarButton = HomeRightBarButton()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    
    private func setNavigationLeftBarButton() {
        let leftBarButton = HomeLeftBarButton()
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftBarButton
    }
}


