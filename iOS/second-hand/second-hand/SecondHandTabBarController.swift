//
//  SecondHandTabBarController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SecondHandTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController()
    }
    
    private func addViewController() {
        let home = HomeViewController()
        let saleLog = SaleLogViewController()
        let wishList = WishListViewController()
        let chatting = ChattingViewController()
        let myAccount = MyAccountViewController()
        
        let viewControllers : [UIViewController] = [home,saleLog,wishList,chatting,myAccount]
        home.setNavigationBar()
        for index in .zero..<viewControllers.count {
            viewControllers[index].tabBarItem = TabBarItems.setItems()[index]
        }
        self.setViewControllers(viewControllers, animated: true)
    }
}


