//
//  CategoryItemListViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/28.
//

import UIKit

class CategoryItemListViewController: UIViewController {
    private var category: Int?
    private var productListCollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    private var items: [SellingItem] = []
    private var page: Int = 0
    private var isLoadingItems = true
    private var dataSource: UICollectionViewDiffableDataSource<Section, SellingItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        setupInfiniteScroll()
        fetchItemList(page: page)
        setupDataSource()
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
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let figmaCellHight = 152
        let figmaHeight = 852
        
        layout.minimumLineSpacing = 1.1
        layout.itemSize = .init(width: self.view.frame.width, height: CGFloat(figmaCellHight*figmaHeight)/self.view.frame.height)
        productListCollectionView.setCollectionViewLayout(layout, animated: true)
        self.view.addSubview(productListCollectionView)
        setCollectionViewConstraints()
    }
    
    private func setCollectionViewConstraints() {
        productListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                productListCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                productListCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                productListCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                productListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    private func setupInfiniteScroll() {
        productListCollectionView.delegate = self
    }
    
    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func showTabBar() {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func getCategory(category: Int) {
        self.category = category
    }
    
    private func fetchItemList(page: Int) {
        guard let url = URL(string: Server.shared.itemsListURL(page: page, regionID: 2729060200, category: self.category)) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: ItemListSuccess.self, what: nil, fromURL: url) { (result: Result<[ItemListSuccess], Error>) in
            switch result {
            case .success(let response) :
                guard let itemList = response.last?.data else {
                    return
                }
                
                if itemList.items.count == 0 {
                    self.isLoadingItems = false
                    print("마지막 페이지에 대한 처리")
                }
                
                itemList.items.forEach { item in
                    self.items.append(self.convertToHashable(from: item))
                }
                self.applySnapshot()
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SellingItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.items, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func convertToHashable(from item : Item) -> SellingItem {
        let result =
        SellingItem(id: item.id,thumbnailImageUrl: item.thumbnailUrl!, title: item.title, price: item.price, region: item.region.district, createdAt: item.createdAt, chatCount: item.chatCount ,likeCount: item.likeCount, status: item.status)
        return result
    }
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductListCollectionViewCell,SellingItem> { (cell, indexPath, item) in
            cell.setUI(from: self.items[indexPath.item])
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, SellingItem>(collectionView: productListCollectionView) { (collectionView, indexPath, itemIdentifier: SellingItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }

}

extension CategoryItemListViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           let id = items[indexPath.item].id
           
           let url = Server.shared.itemDetailURL(itemId: id)
           let itemDetailViewController = ItemDetailViewController()
           
           itemDetailViewController.setItemDetailURL(url)
           hideTabBar()
           self.navigationController?.pushViewController(itemDetailViewController, animated: true)
       }
    
    private func extractItemIdFromTouchedCell(indexPath: IndexPath) -> Int{
        let itemId = items[IndexPath(item: .zero, section: .zero).item].id - indexPath.item
        return itemId
    }
}
