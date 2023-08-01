//
//  TableViewInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class TableViewInChatroom: UITableView {
    private let chat = ["하이하이하이하이하이하이하이하이하이하이하이"]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        self.delegate = self
        self.dataSource = self
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        self.register(MyCell.self, forCellReuseIdentifier: MyCell.identifier)
    }
    
    private func scrollToLastCell(animated: Bool = true) {
        let lastSection = self.numberOfSections - 1
        guard lastSection >= 0 else {
            return
        }
        
        let lastRow = self.numberOfRows(inSection: lastSection) - 1
        guard lastRow >= 0 else {
            return
        }
        
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
        self.scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
    }
}

extension TableViewInChatroom : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = 45 + 23.0 * CGFloat((chat[indexPath.row].count / 18))
        return rowHeight
    }
}

extension TableViewInChatroom : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MyCell(text:chat[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        scrollToLastCell(animated: true)
    }
    
}
