//
//  RegionViewController.swift
//  second-hand
//
//  Created by SONG on 2023/08/30.
//

import UIKit
import RxSwift
import RxCocoa

class RegionSearchingViewController: UIViewController {
    enum Section: CaseIterable {
        case regionList
    }
    
    let regionsController = RegionController()
    let searchBar = UISearchBar(frame: .zero)
    var regionsCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RegionController.RegionHashable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        navigationItem.title = "동네 찾기"
        configureHierarchy()
        configureDataSource()
        filterCell(with: nil)
        print(UserInfoManager.shared.userInfo?.regions)
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
    
    func filterCell(with filter: String?) {
        let regions = regionsController.filteredRegions(with: filter).sorted { $0.name < $1.name }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, RegionController.RegionHashable>()
        snapshot.appendSections([.main])
        snapshot.appendItems(regions)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension RegionSearchingViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        return layout
    }
    
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        let views = ["cv": collectionView, "searchBar": searchBar]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[cv]|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[searchBar]|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:[searchBar]-20-[cv]|", options: [], metrics: nil, views: views))
        constraints.append(searchBar.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0))
        NSLayoutConstraint.activate(constraints)
        regionsCollectionView = collectionView
        regionsCollectionView.delegate = self
        searchBar.delegate = self
    }
    
    @objc func backButtonTapped() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    private func convertToRegionFrom(id:Int,district:String,onFocus:Bool) -> Region {
        return Region(id: id, onFocus: onFocus, district: district)
    }
}

extension RegionSearchingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCell(with: searchText)
    }
}

extension RegionSearchingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell이 클릭되었을 때
        guard let url = URL(string:Server.shared.createChangeRegionURL()) else {
            return
        }
        let regionID = regionsController.havingCell[indexPath.item].regionId
        let district = regionsController.havingCell[indexPath.item].name.split(separator: " ")[2]
        
        let region = convertToRegionFrom(id: regionID, district: String(district), onFocus: false)
        
        let body = JSONCreater().createChangingRegionBody(region)
        // 검색 -> 필터링된 cell 표시 -> 초기cell상태와 다른 indexPath가 부여됨, 근데 API가
        NetworkManager().sendPut(decodeType: BooleanResponse.self, what: body, header: nil, fromURL: url) { (result: Result<BooleanResponse, Error>) in
            switch result {
            case .success(let response) :
                print(response)
                
            case .failure(let error) :
                print(error)
            }
        }
    }
}
