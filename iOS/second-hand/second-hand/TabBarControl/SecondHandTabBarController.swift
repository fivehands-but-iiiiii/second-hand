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
        self.delegate = self
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
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let title = viewController.tabBarItem.title
        
        if !UserInfoManager.shared.isLogOn {
            switch title {
            case "판매내역", "관심목록", "채팅":
                let alert = UIAlertController(title: "로그인 필요", message: "해당 기능을 사용하려면 로그인이 필요합니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            default :
                return true
            }
        } else {
            return true
        }
    }
}
