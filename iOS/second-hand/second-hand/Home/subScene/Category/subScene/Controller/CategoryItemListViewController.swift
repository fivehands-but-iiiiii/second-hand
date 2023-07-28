//
//  CategoryItemListViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/28.
//

import UIKit

class CategoryItemListViewController: UIViewController {
    private var category: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        setNavigationBar(category: category ?? 0)
    }
    
    private func setNavigationBar(category: Int) {
        let stringCategory = Category.convertCategoryIntToString(category)
        self.navigationItem.title = stringCategory
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func showTabBar() {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func setItemList(category: Int) {
        self.category = category
    }

}
