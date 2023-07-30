//
//  InterestingListViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

enum Section: CaseIterable {
    case main
}

final class WishListViewController: NavigationUnderLineViewController, ButtonActionDelegate {
    private var categoryScrollView = CategoryScrollView()
    private var productListCollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    private let setLocationViewController = SetLocationViewController()
    private let joinViewController = JoinViewController()
    private var items: [SellingItem] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, SellingItem>!
    private var isLogin = false
    private let registerProductButton = UIButton()
    private var page: Int = 0
    private var isLoadingItems = true
    private var categoryNumber = 0
    private var lastCategoryNumber : Int? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setCategory()
        getCategories()
        setCollectionView()
        setObserver()
        setupInfiniteScroll()
        page = 0
        fetchItemList(page: page)
        setupDataSource()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(true)
        categoryScrollView.categoriStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

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
        allCategoriButton.addTarget(nil, action: #selector(categoryButtonTapped), for: .touchUpInside)
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
    
    private func makeButton(category: String)  {
        let categoryButton = CategoryButton(title: category)
        categoryScrollView.categoriStackView.addArrangedSubview(categoryButton)
        let categoryNumber = Category.convertCategoryStringToInt(category)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        categoryButton.tag = categoryNumber
    }
    
    @objc private func categoryButtonTapped(_ sender: CategoryButton) {
       
        //(버튼)활성화UI를 비활성화UI로
        for case let button as CategoryButton in categoryScrollView.categoriStackView.arrangedSubviews {
            if button.backgroundColor == .orange {
                button.changeWhiteColor()
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 1
            }
        }
        
        guard sender.currentTitle != "전체" else {
            sender.changeOrangeColor()
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.layer.borderWidth = 0
            page = 0
            fetchItemList(page: page)
            return
        }
        
        //(버튼)비활성화UI를 활성화UI로
        categoryNumber = sender.tag
        sender.changeOrangeColor()
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.layer.borderWidth = 0
        
        //해당 상품리스트가 조회되도록
        page = 0
        fetchItemList(page: page, categoryNumber: categoryNumber)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupInfiniteScroll() {
        productListCollectionView.delegate = self
    }
    
    private func loadNextPage() {
        if categoryNumber == 0 {
            page += 1
            fetchItemList(page: page)
        } else {
            page += 1
            fetchItemList(page: page, categoryNumber: categoryNumber)
        }
    }

    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SellingItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.items, toSection: .main)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLogin(_:)), name: NSNotification.Name("LOGIN"), object: nil)
    }
    
    @objc func didRecieveLogin(_ notification: Notification) {
        self.isLogin = true
        print("로그인 되었습니다.")
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
                productListCollectionView.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor, constant: 10),
                productListCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                productListCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                productListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductListCollectionViewCell,SellingItem> { (cell, indexPath, item) in
            cell.setUI(from: self.items[indexPath.item])
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, SellingItem>(collectionView: productListCollectionView) { (collectionView, indexPath, itemIdentifier: SellingItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func convertToHashable(from item : WishItem) -> SellingItem {
        let result =
        SellingItem(id: item.id,thumbnailImageUrl: item.thumbnailUrl, title: item.title, price: item.price, region: item.region, createdAt: item.createdAt, chatCount: item.chatCount ,likeCount: item.likeCount, status: item.status)
        return result
    }
    
    private func fetchItemList(page: Int, categoryNumber: Int? = nil) {
        lastCategoryNumber = categoryNumber
        var urlString: String
        if let category = categoryNumber {
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
                
                var newItems: [SellingItem] = []
                itemList.data.items.forEach { item in
                    newItems.append((self?.convertToHashable(from: item))!)
                }
                
                if page == 0 {
                    self?.items.removeAll()
                }
                
                self?.items.append(contentsOf: newItems)
                self?.applySnapshot()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func backButtonTouched() {
        fetchItemList(page: page, categoryNumber: lastCategoryNumber)
        print("패치 완료 \(Category.convertCategoryIntToString(lastCategoryNumber ?? 19))")
    }

    private func getCategories() {
        guard let url = URL(string: Server.shared.url(for: .wishlistCategories)) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: GetCategories.self, what: nil, fromURL: url) { [weak self] (result: Result<[GetCategories], Error>) in
            switch result {
            case .success(let data):
                guard let categories = data.last?.data.categories else {
                    return
                }
                
                //찜했던 상품들이 해당하는 카테고리를 버튼으로 만듬
                categories.forEach { category in
                    let temp = Category.convertCategoryIntToString(category)
                    self?.makeButton(category: temp)
                }
                
                self?.applySnapshot()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSection = collectionView.numberOfSections - 1
        let lastItem = collectionView.numberOfItems(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.item == lastItem {
            loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           let id = items[indexPath.item].id
           
           let url = Server.shared.itemDetailURL(itemId: id)
           let itemDetailViewController = ItemDetailViewController()
           
           itemDetailViewController.setItemDetailURL(url)
           hideTabBar()
           self.navigationController?.pushViewController(itemDetailViewController, animated: true)
       }
    
    private func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    //TODO: 콜렉션뷰 아래 섹션으로 가면 값이 이상해진다. 추후 확인하도록.
    private func extractItemIdFromTouchedCell(indexPath: IndexPath) -> Int{
        let itemId = items[IndexPath(item: .zero, section: .zero).item].id - indexPath.item
        return itemId
    }
}

