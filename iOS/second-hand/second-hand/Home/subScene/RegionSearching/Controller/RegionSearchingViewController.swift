//
//  RegionViewController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit

class RegionSearchingViewController: UIViewController {
    
    let regionsController = RegionController()
    let searchBar = UISearchBar(frame: .zero)
    var regionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        navigationItem.title = "동네 찾기"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func commonInit() {
        self.view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

}
    }
    
    @objc func backButtonTapped() {

}

extension RegionSearchingViewController: UICollectionViewDelegate {
        
    }
    
        let body = JSONCreater().createChangingRegionBody(region)
        
    }
}
