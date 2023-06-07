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
        tabBar.tintColor = .black
    }
    
    private func addViewController() {
        let home = HomeViewController()
        let saleLog = SaleLogViewController()
        let wishList = WishListViewController()
        let chatting = ChattingViewController()
        let myAccount = MyAccountViewController()
        
        let viewControllers : [UIViewController] = [home,saleLog,wishList,chatting,myAccount]
        
        let navigationControllerEmbeded = viewControllers.map { viewController in
            UINavigationController(rootViewController: viewController)
        }
        
        navigationControllerEmbeded.enumerated().forEach { index, controller in
            controller.tabBarItem = TabBarItems.setItems()[index]
        }
        
        self.setViewControllers(navigationControllerEmbeded, animated: true)
    }
    
}


