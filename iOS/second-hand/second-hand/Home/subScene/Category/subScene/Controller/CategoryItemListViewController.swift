//
//  CategoryItemListViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/28.
//

import UIKit

class CategoryItemListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = ""
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func showTabBar() {
        tabBarController?.tabBar.isHidden = false
        
    }

}
