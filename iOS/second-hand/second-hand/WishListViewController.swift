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
           layout()
           setup()
           makeButton(categori: "가구/인테리어")
           makeButton(categori: "안녕안녕")
           makeButton(categori: "하하하")
           makeButton(categori: "스크롤~~된다~~")
           makeButton(categori: "길게길게길게길게길게길게")
       }
    
    func setup() {
        //네비게이션
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "관심 목록"
        
        let allCategoriButton = CategoriButton(title: "전체")
        categoriScrollView.categoriStackView.addArrangedSubview(allCategoriButton)
        allCategoriButton.backgroundColor = UIColor.orange
        allCategoriButton.setTitleColor(.white, for: .normal)
        allCategoriButton.layer.borderWidth = 0
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
       
       func makeButton(categori: String) {
           let categoriLabel = CategoriButton(title: categori)
           categoriScrollView.categoriStackView.addArrangedSubview(categoriLabel)
       }
}
