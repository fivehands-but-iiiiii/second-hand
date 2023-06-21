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
    let id = UUID()
    var title: String
    var price: String
    var location: String
    var registerTime: String
}

class HomeViewController: NavigationUnderLineViewController, ButtonCustomViewDelegate {
    var productListCollectionView : UICollectionView!
    var setLocationViewController = SetLocationViewController()
    private var isLogin = false
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    var productArray = [("선풍기", "25,000원", "역삼동", "4시간전"), ("에어팟", "50,000원", "점봉동", "1시간전"), ("냉장고", "999,999,999원","강남", "1초전"), ("냉장고", "999,999,999원","강남", "1초전"), ("냉장고", "999,999,999원","강남", "1초전"), ("냉장고", "999,999,999원","강남", "1초전"), ("냉장고", "999,999,999원","강남", "1초전"), ("냉장고", "999,999,999원","강남", "1초전")]

       lazy var products: [Product] = {
           return self.productArray.map { Product(title: $0.0, price: $0.1, location: $0.2, registerTime: $0.3) }
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setObserver()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLogin(_:)), name: NSNotification.Name("LOGIN"), object: nil)
    }
    
    @objc func didRecieveLogin(_ notification: Notification) {
        self.isLogin = true
        print("로그인 되었습니다.")
    }
    
    private func setUI() {
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
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
    
}


