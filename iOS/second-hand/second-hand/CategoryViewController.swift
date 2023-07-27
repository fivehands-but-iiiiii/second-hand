//
//  CategoryViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/27.
//

import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    private func setUI() {
          self.view.backgroundColor = .white
          setNavigationBar()
          hideTabBar()
      }
      
      private func setNavigationBar() {
          self.navigationItem.title = "카테고리"
          
          navigationController?.navigationBar.tintColor = .black
          navigationController?.navigationBar.topItem?.backButtonTitle = "뒤로"
      }
      
      private func hideTabBar() {
          tabBarController?.tabBar.isHidden = true
      }
      
}
