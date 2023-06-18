//
//  HomeViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class HomeViewController: NavigationUnderLineViewController {
    private var isLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setObserver()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLogin(_:)), name: NSNotification.Name("LOGIN"), object: nil)
    }
    
    @objc func didRecieveLogin(_ notification: Notification) {
        self.isLogin = true
        print("로그인 되었습니다.")
    }
    
    private func setUI() {
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


