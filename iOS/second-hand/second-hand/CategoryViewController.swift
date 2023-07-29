//
//  CategoryViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/27.
//

import UIKit

class CategoryViewController: UIViewController {
    private var categoryList: [CategoryData] = []
    private var categoryListCollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCategoryCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "카테고리"
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = "뒤로"
    }
    
    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func showTabBar() {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    private func setCategoryCollectionView() {
        categoryListCollectionView.dataSource = self
        categoryListCollectionView.delegate = self
        categoryListCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        let margin: CGFloat = 40
        self.view.addSubview(categoryListCollectionView)
        categoryListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryListCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: margin),
            categoryListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            categoryListCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            categoryListCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
        ])
        
        sendGet()
    }
    
    private func sendGet() {
        NetworkManager.sendGET(decodeType: CategoryData.self, what: nil, fromURL: URL(string: Server.shared.url(for: .resourceCategories))!) { (result: Result<[CategoryData], Error>) in
            switch result {
            case .success(let data) :
                self.categoryList = data
                DispatchQueue.main.async {
                    self.categoryListCollectionView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryList.last?.data.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell
        
        let categoryElement = categoryList[0].data.categories[indexPath.row]
        cell?.title.text = categoryElement.title
        cell?.imageUrl = categoryElement.iconUrl
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 80
        let cellHeight: CGFloat = 68
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
