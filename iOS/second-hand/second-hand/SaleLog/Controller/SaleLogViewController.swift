//
//  SaleLogViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit


final class SaleLogViewController: UIViewController {
    private let titleLabel = UILabel()
    private let segmentControl = UISegmentedControl(items: ["판매중", "판매완료"])
    private var productListCollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    private var items: [SellingItem] = []
    private var page: Int = 0
    private var isLoadingItems = true
    private var dataSource: UICollectionViewDiffableDataSource<Section, SellingItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "판매 내역"
        setNavigationBar()
        setSegmentControl()
        setCollectionView()
        setupInfiniteScroll()
        page = 0
        fetchItemList(page: page, isSales: true)
        setupDataSource()
    }
    
    private func setSegmentControl() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        segmentControlLayout()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 100))
        
        guard let navigationBar = navigationController?.navigationBar else {return}
        let borderView = UIView(frame: CGRect(x: .zero, y: navigationBar.frame.maxY, width: navigationBar.frame.width, height: 1))
        
        borderView.backgroundColor = UIColor.neutralBorder
        navigationBar.addSubview(borderView)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        
        let selectedIndex = sender.selectedSegmentIndex

        if selectedIndex == 0 {
            page = 0
            fetchItemList(page: page, isSales: true)
            setupDataSource()
        }else {
            page = 0
            fetchItemList(page: page, isSales: false)
            setupDataSource()
        }
    }
    
    private func segmentControlLayout() {
        self.view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 102*heightRatio),
            segmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: 240*widthRatio),
            segmentControl.heightAnchor.constraint(equalToConstant: 32*heightRatio)
        ])
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
                productListCollectionView.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor, constant: 10),
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
    
    private func fetchItemList(page: Int, isSales: Bool) {
        guard let url = URL(string: Server.shared.urlBoolType(path: .itemsMine, query: .isSales, queryValue: isSales, page: page)) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: MyItemListSuccess.self, what: nil, fromURL: url) { (result: Result<[MyItemListSuccess], Error>) in
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
    
    private func convertToHashable(from item : MyItem) -> SellingItem {
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

extension SaleLogViewController: UICollectionViewDelegate {
   
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
