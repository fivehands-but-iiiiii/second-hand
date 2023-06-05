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
        let list : [UIViewController] = [HomeViewController(),SaleLogViewController(),InterestingListViewController(),ChattingViewController(),MyAccountViewController()]
        for index in 0...4 {
            list[index].tabBarItem = TabBarItems.setItems()[index]
        }
        self.setViewControllers(list, animated: true)
    }
}


