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
    private var currentPage: Int = 0
    private var isLoadingItems = true
    private var dataSource: UICollectionViewDiffableDataSource<Section, SellingItem>!
    private let networkManager = NetworkManager()
    private let modifyItem = RegisterNewProductViewController()
    private let itemDetailViewController = ItemDetailViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.viewDidLoad()
        //setNavigationBar()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = .white
        self.navigationItem.title = "판매 내역"
        items.removeAll()
        isLoadingItems = true
        setSegmentControl()
        setCollectionView()
        setupInfiniteScroll()
        currentPage = 0
        fetchItemList(page: currentPage, isSales: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupDataSource()
        setdelegate()
    }
    
    private func setdelegate() {
        modifyItem.delegate = self
        modifyItem.updateDelegate = self
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
        
        if !navigationBar.contains(borderView) {
            navigationBar.addSubview(borderView)
        }
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        
        items.removeAll()
        isLoadingItems = true
        
        let selectedIndex = sender.selectedSegmentIndex
        
        if selectedIndex == 0 {
            currentPage = 0
            fetchItemList(page: currentPage, isSales: true)
        }else {
            currentPage = 0
            fetchItemList(page: currentPage, isSales: false)
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
        
        NetworkManager.sendGET(decodeType: MyItemListSuccess.self,header: nil, body: nil, fromURL: url) { (result: Result<[MyItemListSuccess], Error>) in
            switch result {
            case .success(let data):
                guard let itemList = data.last else {
                    return
                }
                
                if itemList.data.items.count == 0 {
                    self.isLoadingItems = false
                    print("마지막 페이지에 대한 처리")
                }
                
                itemList.data.items.forEach { item in
                    self.items.append(self.convertToHashable(from: item))
                }
                self.applySnapshot()
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadNextPage(isSales: Bool) {
        if !isLoadingItems {
            return
        }
        self.isLoadingItems  = true
        currentPage += 1
        fetchItemList(page: currentPage, isSales: isSales)
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
            
            if indexPath.item >= 0, indexPath.item < self.items.count {
                cell.setUI(from: self.items[indexPath.item])
                cell.setMoreButton()
                cell.moreButtonTappedDelegate = self
            }
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, SellingItem>(collectionView: productListCollectionView) { (collectionView, indexPath, itemIdentifier: SellingItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
}

extension SaleLogViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSection = collectionView.numberOfSections - 1
        let lastItem = collectionView.numberOfItems(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.item == lastItem {
            if segmentControl.selectedSegmentIndex == 0 {
                loadNextPage(isSales: true)
            }else {
                loadNextPage(isSales: false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id = items[indexPath.item].id
        
        let url = Server.shared.itemDetailURL(itemId: id)
        let itemDetailViewController = ItemDetailViewController()
        
        itemDetailViewController.setItemDetailURL(url)
        hideTabBar()
        itemDetailViewController.lastViewControllerSet(what: .home)
        self.navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
    
    private func extractItemIdFromTouchedCell(indexPath: IndexPath) -> Int{
        let itemId = items[IndexPath(item: .zero, section: .zero).item].id - indexPath.item
        return itemId
    }
}

extension SaleLogViewController: MoreButtonTappedDelegate {
    func moreButtonTapped(forIndexPath indexPath: IndexPath) {
        let id = items[indexPath.item].id
        print("More 버튼이 눌린 아이템의 id:", id)
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "게시글 수정", style: .default, handler: { [self] (ACTION:UIAlertAction) in
            guard let url = URL(string: Server.shared.itemDetailURL(itemId: id)) else {
                return
            }
            NetworkManager.sendGET(decodeType: ItemDetailInfoSuccess.self,header: nil, body: nil, fromURL: url) { [self] (result: Result<[ItemDetailInfoSuccess], Error>) in
                switch result {
                case .success(let data) :
                    guard let detailInfo = data.last?.data else {
                        return
                    }
                    
                    modifyItem.getItemInfo(title: detailInfo.title, price: detailInfo.price.comma(), contents: detailInfo.contents, images: detailInfo.images)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            present(UINavigationController(rootViewController: modifyItem), animated: true)
            modifyItem.updateId(id: id)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "판매중 상태로 전환", style: .default, handler: { [self] (ACTION:UIAlertAction) in
            changeStatus(status: .onSale, id: id)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "판매완료 상태로 전환", style: .default, handler: { [self] (Action: UIAlertAction) in
            changeStatus(status: .salesCompleted, id: id)
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (ACTION:UIAlertAction) in
            changeStatus(status: .delete, id: id)
            productListCollectionView.reloadData()
            updateScreen()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func changeStatus(status: ItemStatus, id:Int) {
        var url: URL
        var data = [String:Int]()
        switch status {
        case .onSale:
            url = URL(string: Server.shared.changeItemStatusUrl(for: .items, id: id, status: .status))!
            petchItem(url: url, data: ["status": 0])
        case .reservation:
            url = URL(string: Server.shared.changeItemStatusUrl(for: .items, id: id, status: .status))!
            petchItem(url: url, data: ["status": 1])
        case .salesCompleted:
            url = URL(string: Server.shared.changeItemStatusUrl(for: .items, id: id, status: .status))!
            petchItem(url: url, data: ["status": 2])
        case .delete:
            url = URL(string: Server.shared.itemDetailURL(itemId: id))!
            deleteItem(url: url)
        }
        productListCollectionView.reloadData()
    }
    
    enum ItemStatus {
        case onSale
        case salesCompleted
        case delete
        case reservation
    }
    
    func toggleSegmentValue() {
        if segmentControl.selectedSegmentIndex == 0 {
            segmentControl.selectedSegmentIndex = 1
        }else {
            segmentControl.selectedSegmentIndex = 0
        }
        segmentValueChanged(segmentControl)
    }
    
    func petchItem(url: URL, data: [String:Int]) {
        let jsonData = try? JSONSerialization.data(withJSONObject: data)
        
        networkManager.sendPatch(decodeType: ChangeStatusItem.self, what: jsonData, fromURL: url) { (result: Result<ChangeStatusItem, Error>) in
            switch result {
            case .success(let data):
                if !data.message.isEmpty {
                    print(data.message)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //상품판매완료/판매중일때만
        toggleSegmentValue()
    }
    
    func deleteItem(url: URL) {
        networkManager.sendDelete(decodeType: ChangeStatusItem.self, what: nil, fromURL: url) { (result: Result<ChangeStatusItem?, Error>) in
            switch result {
            case .success(let data):
                print("성공적으로 삭제되었습니다.")
                if data?.message != nil {
                    print(data!.message)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SaleLogViewController: CompleteModify {
    func didCompleteModifyItem() {
        productListCollectionView.reloadData()
    }
}

extension SaleLogViewController: StatusButtonChange {
    //여기가 왜 안걸림?
    func onsale(id: Int) {
        changeStatus(status: .onSale, id: id)
    }
    
    func reservation(id: Int) {
        changeStatus(status: .reservation, id: id)
    }
    
    func soldOut(id: Int) {
        changeStatus(status: .salesCompleted, id: id)
    }
}

extension SaleLogViewController: UpdateDelegate {
    func updateScreen() {
        items.removeAll()
        setupDataSource()
        currentPage = 0
        fetchItemList(page: currentPage, isSales: segmentControl.selectedSegmentIndex == 0)
        
    }
}
