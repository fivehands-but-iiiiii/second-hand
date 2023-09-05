import UIKit

final class HomeViewController: NavigationUnderLineViewController{
    
    enum Section: CaseIterable {
        case main
    }
    
    private var productListCollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    private let setLocationViewController = SetLocationViewController()
    private let joinViewController = JoinViewController()
    private var items: [SellingItem] = []
    private let categoryViewController = CategoryViewController()
    private var dataSource: UICollectionViewDiffableDataSource<Section, SellingItem>!
    private var isLogin = false
    private let registerProductButton = UIButton()
    private var currentPage: Int = 0
    private var isLoadingItems = true
    private let regionSearchingViewController = RegionSearchingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
        setObserver()
        setupInfiniteScroll()
        getItemList(page: currentPage)
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setRegisterProductButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupInfiniteScroll() {
        productListCollectionView.delegate = self
    }
    
    private func loadNextPage() {
        if !isLoadingItems {
            return
        }
        self.isLoadingItems  = true
        currentPage += 1
        getItemList(page: currentPage)
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
                productListCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                productListCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                productListCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                productListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    private func setNavigationRightBarButton() {
           let rightBarButton = HomeRightBarButton()
           rightBarButton.delegate = self
           navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
       }
    
    private func setNavigationLeftBarButton() {
        let leftBarButton = HomeLeftBarButton()
        let buttonCustomView = leftBarButton.customView as? ButtonCustomView
        buttonCustomView?.delegate = self
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftBarButton
    }
    
    
    func tappedSetLocation() {
        present(UINavigationController(rootViewController: setLocationViewController), animated: true)
    }
    
    private func setRegisterProductButton() {
        guard UserInfoManager.shared.loginToken != nil else{ return }
        registerProductButton.setImage(UIImage(systemName: "plus"), for: .normal)
        registerProductButton.tintColor = .neutralBackground
        registerProductButton.backgroundColor = .accentBackgroundPrimary
        layoutRegisterProductButton()
        
        registerProductButton.addTarget(self, action: #selector(registerProductButtonTapped), for: .touchUpInside)
    }
    
    private func layoutRegisterProductButton() {
        let registerButtonHeightWidth = CGFloat(56)
        self.view.addSubview(registerProductButton)
        registerProductButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerProductButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -107),
            registerProductButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            registerProductButton.widthAnchor.constraint(equalToConstant: registerButtonHeightWidth),
            registerProductButton.heightAnchor.constraint(equalToConstant: registerButtonHeightWidth)
        ])
        
        registerProductButton.clipsToBounds = true
        registerProductButton.layer.cornerRadius = registerButtonHeightWidth / 2
    }
    
    @objc func registerProductButtonTapped() {
        present(UINavigationController(rootViewController: RegisterNewProductViewController()), animated: true)
    }
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProductListCollectionViewCell,SellingItem> { (cell, indexPath, item) in
            cell.setUI(from: self.items[indexPath.item])
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, SellingItem>(collectionView: productListCollectionView) { (collectionView, indexPath, itemIdentifier: SellingItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func convertToHashable(from item : Item) -> SellingItem{
        let result =
        SellingItem(id: item.id,thumbnailImageUrl: item.thumbnailUrl!, title: item.title, price: item.price, region: item.region.district, createdAt: item.createdAt, chatCount: item.chatCount ,likeCount: item.likeCount, status: item.status)
        return result
    }
    
    private func getItemList(page: Int) {
        // TODO: 리전 하드코딩 없애기
        guard let url = URL(string: Server.shared.itemsListURL(page: page, regionID: 2729060200, category: nil)) else {
            return
        }
        NetworkManager.sendGET(decodeType: ItemListSuccess.self,header: nil, body: nil, fromURL: url) { (result: Result<[ItemListSuccess], Error>) in
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
    
}

extension HomeViewController: UICollectionViewDelegate {
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
}

extension HomeViewController: ButtonActionDelegate {
    func homeRightBarButtonTapped() {
        self.navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    func setRegionButtonTouched() {
        self.navigationController?.pushViewController(regionSearchingViewController, animated: true)
    }
}
