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
    var regionListTableView = UITableView()
    
    var disposeBag = DisposeBag()
    
    lazy var dataSource: UITableViewDiffableDataSource<Section, RegionController.RegionHashable> = {
        return UITableViewDiffableDataSource(tableView: regionListTableView) { tableView, indexPath, region in
            let cell = tableView.dequeueReusableCell(withIdentifier: "REGIONCELL", for: indexPath) as? RegionCell
            cell?.label.text = region.name
            cell?.configure()
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func commonInit() {
        self.view.backgroundColor = .white
    }
    
    private func bindUI() {
        let searchBarObservable : Observable<String> = searchBar.rx.text.orEmpty.asObservable()
        
        searchBarObservable
            .flatMapLatest { keyword in
                return self.regionsController.getRegionList(keyword: keyword)
                    .catchAndReturn([])
            }
            .subscribe(onNext: { regions in
                self.regionsController.updateRegionList(data: regions)
                self.showCell()
            })
            .disposed(by: disposeBag)
    }
    
        let backButton = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    }
    
    private func setLayoutTableView() {
        self.view.addSubview(self.regionListTableView)
        self.regionListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.regionListTableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20.0),
                self.regionListTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                self.regionListTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.regionListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ]
        )
    }
}

extension RegionSearchingViewController {

        
        var snapshot = NSDiffableDataSourceSnapshot<Section, RegionController.RegionHashable>()
        snapshot.appendSections([.regionList])
        snapshot.appendItems(regions)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension RegionSearchingViewController {

    @objc func backButtonTapped() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    private func convertToRegionFrom(id:Int,district:String,onFocus:Bool) -> Region {
        return Region(id: id, onFocus: onFocus, district: district)
    }
}

//extension RegionSearchingViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // cell이 클릭되었을 때
//        guard let url = URL(string:Server.shared.createChangeRegionURL()) else {
//            return
//        }
//        let regionID = regionsController.havingCell[indexPath.item].regionId
//        let district = regionsController.havingCell[indexPath.item].name.split(separator: " ")[2]
//
//        let region = convertToRegionFrom(id: regionID, district: String(district), onFocus: false)
//
//        let body = JSONCreater().createChangingRegionBody(region)
//
//        NetworkManager().sendPut(decodeType: BooleanResponse.self, what: body, header: nil, fromURL: url) { (result: Result<BooleanResponse, Error>) in
//            switch result {
//            case .success(let response) :
//                print(response)
//
//            case .failure(let error) :
//                print(error)
//            }
//        }
//    }
//}
