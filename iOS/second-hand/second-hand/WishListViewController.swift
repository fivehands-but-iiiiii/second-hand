//
//  InterestingListViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

final class WishListViewController: NavigationUnderLineViewController {
    private var categoryScrollView = CategoriesScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeButton(category: "가구/인테리어")
        makeButton(category: "안녕안녕")
        makeButton(category: "하하하")
        makeButton(category: "스크롤~~된다~~")
        makeButton(category: "길게길게길게길게길게길게")
    }
    
    private func setupUI() {
        //네비게이션
        self.navigationItem.title = "관심 목록"
        let allCategoriButton = CategoryButton(title: "전체")
        categoryScrollView.categoriStackView.addArrangedSubview(allCategoriButton)
        allCategoriButton.backgroundColor = UIColor.orange
        allCategoriButton.setTitleColor(UIColor.white, for: .normal)
        allCategoriButton.layer.borderWidth = 0
        categoryLayout()
    }
    
    private func categoryLayout() {
        self.view.addSubview(categoryScrollView)
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        NSLayoutConstraint.activate([
            categoryScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16*heightRatio),
            categoryScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16*widthRatio),
            categoryScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16*widthRatio),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 32*heightRatio)
        ])
    }
    
    private func makeButton(category: String) {
        let categoryLabel = CategoryButton(title: category)
        categoryScrollView.categoriStackView.addArrangedSubview(categoryLabel)
    }
}
