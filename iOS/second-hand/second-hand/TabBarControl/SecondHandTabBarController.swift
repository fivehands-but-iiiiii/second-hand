//
//  SecondHandTabBarController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class SecondHandTabBarController: UITabBarController {

    private var isLogined = false
    private let home = HomeViewController()
    private let saleLog = SaleLogViewController()
    private let wishList = WishListViewController()
    private let chatting = ChattingViewController()
    private var myAccount = NotLoginMyAccountViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController()
        tabBar.tintColor = .black
    }
    
    private func addViewController() {
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

extension SecondHandTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == TabBarItemType.myAccount.rawValue {
            
        }
    }
}
