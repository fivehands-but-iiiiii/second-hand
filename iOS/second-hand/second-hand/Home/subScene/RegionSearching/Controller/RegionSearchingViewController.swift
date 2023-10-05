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
        setNavigationBar()
        regionListTableView.register(RegionCell.self, forCellReuseIdentifier: "REGIONCELL")
        setLayoutOfSearchBar()
        setLayoutTableView()
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
    
    private func setNavigationBar() {
        navigationItem.title = "동네 찾기"
        let backButton = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setLayoutOfSearchBar() {
        self.view.addSubview(self.searchBar)
        self.searchBar.placeholder = "행정구역명으로 검색 (ex: 광진구)"
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                self.searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.searchBar.heightAnchor.constraint(equalToConstant: 50.0)
            ]
        )
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

    private func showCell() {
        let regions = self.regionsController.updateComplete()
        
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

extension RegionSearchingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string:Server.shared.createChangeRegionURL()) else {
            return
        }
        let regionID = regionsController.havingCell[indexPath.item].regionId
        let district = regionsController.havingCell[indexPath.item].name.split(separator: " ")[2]

        let region = convertToRegionFrom(id: regionID, district: String(district), onFocus: true)

        let body = JSONCreater().createChangingRegionBody(region)

        NetworkManager().sendPut(decodeType: BooleanResponse.self, what: body, header: nil, fromURL: url) { (result: Result<BooleanResponse, Error>) in
            switch result {
            case .success(let response) :
                self.updateRegion(region: region)
                let alert = UIAlertController(title: "지역 변경 성공", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            case .failure(let error) :
                print(error)
            }
        }
    }
}
