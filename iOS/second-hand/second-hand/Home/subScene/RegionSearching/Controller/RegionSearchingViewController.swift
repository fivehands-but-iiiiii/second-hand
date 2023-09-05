//
//  RegionViewController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit

class RegionSearchingViewController: UIViewController {
    enum Section: CaseIterable {
        case main
    }
    
    let regionsController = RegionController()
    let searchBar = UISearchBar(frame: .zero)
    var regionsCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RegionController.RegionHashable>!
    
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

extension RegionSearchingViewController {
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <RegionCell, RegionController.RegionHashable> { (cell, indexPath, region) in

            cell.label.text = region.name
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, RegionController.RegionHashable>(collectionView: regionsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: RegionController.RegionHashable) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
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
