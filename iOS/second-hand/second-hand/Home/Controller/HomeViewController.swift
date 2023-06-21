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


