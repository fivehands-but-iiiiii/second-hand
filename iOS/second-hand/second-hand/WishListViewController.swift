//
//  InterestingListViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class WishListViewController: UIViewController {
    var categoriScrollView = CategoriesScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "관심 목록"
        categoriScrollView.backgroundColor = .purple
        layout()
    }
    
    func layout() {
        self.view.addSubview(categoriScrollView)
        categoriScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 114),
            categoriScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            categoriScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            categoriScrollView.heightAnchor.constraint(equalToConstant: 32)
                ])

    }
}
