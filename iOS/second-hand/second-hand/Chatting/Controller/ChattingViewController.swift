//
//  ChattingViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//

import UIKit

enum ChattingSection: CaseIterable {
    case main
}

final class ChattingViewController: NavigationUnderLineViewController {
    
    private let tableView = UITableView()
    private let chattingRoomTableViewCell = ChattingRoomTableViewCell(style: .default, reuseIdentifier: ChattingRoomTableViewCell.identifier)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChattingRoomTableViewCell.self, forCellReuseIdentifier: ChattingRoomTableViewCell.identifier)
        self.navigationItem.title = "채팅"
        setTableView()
        layout()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
    }
    
}

extension ChattingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ChattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChattingSection.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingRoomTableViewCell.identifier, for: indexPath) as? ChattingRoomTableViewCell else {
            return UITableViewCell()
        }
       
        return cell
        
    }
}


