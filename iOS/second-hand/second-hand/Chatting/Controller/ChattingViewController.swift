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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "채팅"
        setTableView()
        layout()
    }
    
    private func setTableView() {
        tableView.dataSource = self
    }
    
    private func layout() {
        
        
    }
    

}

extension ChattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChattingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingRoomCell", for: indexPath) as! ChattingRoomTableViewCell
        
        return cell
        
    }
}


