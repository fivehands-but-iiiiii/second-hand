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
    
    private func fetchItemList(page: Int, categoryNumber: Int? = nil) {
        var urlString: String
        if let category = self.category {
            urlString = Server.shared.wishItemListCategoryURL(page: page, categoryValue: category)
        } else {
            urlString = Server.shared.wishItemListURL(page: page)
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: WishItemList.self, what: nil, fromURL: url) { [weak self] (result: Result<[WishItemList], Error>) in
            switch result {
            case .success(let data):
                guard let itemList = data.last else {
                    return
                }
                
                if itemList.data.items.count == 0 {
                    self?.isLoadingItems = false
                    print("마지막 페이지에 대한 처리")
                }
                
                // 새로운 페이지의 데이터를 새로운 배열에 저장합니다.
                var newItems: [SellingItem] = []
                itemList.data.items.forEach { item in
                    newItems.append((self?.convertToHashable(from: item))!)
                }
                
                // 현재 페이지가 0인 경우에만 기존 items 배열을 비웁니다.
                if page == 0 {
                    self?.items.removeAll()
                }
                
                // 새로운 페이지의 데이터를 기존 items 배열에 추가합니다.
                self?.items.append(contentsOf: newItems)
                self?.applySnapshot()
                
            case .failure(let error):
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
    
    private func convertToHashable(from item : WishItem) -> SellingItem {
        let result =
        SellingItem(id: item.id,thumbnailImageUrl: item.thumbnailUrl, title: item.title, price: item.price, region: item.region, createdAt: item.createdAt, chatCount: item.chatCount ,likeCount: item.likeCount, status: item.status)
        return result
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
