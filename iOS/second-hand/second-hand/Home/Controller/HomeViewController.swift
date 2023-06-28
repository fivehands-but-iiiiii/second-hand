//
//  HomeViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit


enum Section: CaseIterable {
       case main
}

struct Product: Hashable {
    var id : Int
    var title: String
    var price: String
    var location: String
    var registerTime: String
    let chatCount = UILabel()
    let wishCount = UILabel()
}

final class HomeViewController: NavigationUnderLineViewController, ButtonCustomViewDelegate {
    
    enum Section: CaseIterable {
        case main
    }

    private var productListCollectionView : UICollectionView!
    private let setLocationViewController = SetLocationViewController()
    private let joinViewController = JoinViewController()
    private let registerNewProductViewController = RegisterNewProductViewController()
    private var productArray : [ItemList] = []

    private lazy var products: [Product] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>?
    private var isLogin = false
    private let registerProductButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewController()
        setObserver()
        setupDataSource()
        applyInitialSnapshot()
        getItemList()
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products, toSection: .main)
 
        dataSource?.apply(snapshot, animatingDifferences: true)

    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLogin(_:)), name: NSNotification.Name("LOGIN"), object: nil)
    }
    
    @objc func didRecieveLogin(_ notification: Notification) {
        self.isLogin = true
        print("로그인 되었습니다.")
    }
    
    private func setCollectionViewController() {

        let layout = UICollectionViewFlowLayout()
        let figmaCellHight = 152
        let figmaHeight = 852
        
        layout.minimumLineSpacing = 1.1
        layout.itemSize = .init(width: self.view.frame.width, height: CGFloat(figmaCellHight*figmaHeight)/self.view.frame.height)

        productListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.view.addSubview(productListCollectionView)

        setNavigationRightBarButton()
        setNavigationLeftBarButton()
        setRegisterProductButton()
    }
    
    private func setNavigationRightBarButton() {
        let rightBarButton = HomeRightBarButton()
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
        present(UINavigationController(rootViewController: registerNewProductViewController), animated: true)
    }
    
    private func setupDataSource() {
        self.productListCollectionView.register(HomeProductCollectionViewCell.self, forCellWithReuseIdentifier: HomeProductCollectionViewCell.identifier)
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Product>.init(collectionView: productListCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.identifier, for: indexPath) as? HomeProductCollectionViewCell else { preconditionFailure() }
            
            cell.configure(title: itemIdentifier.title, price: itemIdentifier.price, location: itemIdentifier.location, registerTime: itemIdentifier.registerTime)

            return cell
        })
    }
    
    private func getItemList() {
        
        guard let url = URL(string: Server.shared.itemsListURL(page: 2, regionID: 1)) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: ItemList.self, what: nil, fromURL: url) { (result: Result<[ItemList], Error>) in
            switch result {
            case .success(let itemList) :
                print(itemList)
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }

}


