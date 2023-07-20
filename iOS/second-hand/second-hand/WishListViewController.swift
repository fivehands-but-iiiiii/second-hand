//
//  InterestingListViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

final class WishListViewController: NavigationUnderLineViewController {
    private var categoryScrollView = CategoryScrollView()
    private var wishlistCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategory()
        setCollectionView()
        makeButton(category: "가구/인테리어")
        makeButton(category: "안녕안녕")
        makeButton(category: "하하하")
        makeButton(category: "스크롤~~된다~~")
        makeButton(category: "길게길게길게길게길게길게")
    }
    
    private func setCategory() {
        //네비게이션
        self.navigationItem.title = "관심 목록"
        let allCategoriButton = CategoryButton(title: "전체")
        categoryScrollView.categoriStackView.addArrangedSubview(allCategoriButton)
        allCategoriButton.backgroundColor = UIColor.orange
        allCategoriButton.setTitleColor(UIColor.white, for: .normal)
        allCategoriButton.layer.borderWidth = 0
        categoryLayout()
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 150)
        wishlistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        wishlistCollectionView.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier: WishListCollectionViewCell.identifier)
        collectionViewConstraint()
    }
    
    private func categoryLayout() {
        self.view.addSubview(categoryScrollView)
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 852
        let figmaWidth: CGFloat = 391
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        NSLayoutConstraint.activate([
            categoryScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10*heightRatio),
            categoryScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16*widthRatio),
            categoryScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16*widthRatio),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 32*heightRatio)
        ])
    }
    
    private func makeButton(category: String) {
        let categoryLabel = CategoryButton(title: category)
        categoryScrollView.categoriStackView.addArrangedSubview(categoryLabel)
    }
    
    private func collectionViewConstraint() {
        self.view.addSubview(wishlistCollectionView)
        wishlistCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wishlistCollectionView.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor, constant: 10),
            wishlistCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            wishlistCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            wishlistCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension WishListViewController: UICollectionViewDelegate {
    
}

extension WishListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCollectionViewCell.identifier, for: indexPath) as? WishListCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
}
