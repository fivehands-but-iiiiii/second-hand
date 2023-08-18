//
//  TableViewInChatrromList.swift
//  second-hand
//
//  Created by SONG on 2023/08/13.
//

import UIKit

class TableViewInChatroomList: UITableView {
    private var havingCell : [CellOfChatroomList] = []
    weak var delegateForChatroomSelection: ButtonActionDelegate?
    weak var delegateForScrollAction: ScrollActionDelegate?
    
    init(chatroomList: ChatroomListModel) {
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.havingCell = makeHavingCell(from: chatroomList)
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerCell() {
        self.register(CellOfChatroomList.self, forCellReuseIdentifier: CellOfChatroomList.identifier)
    }
    
    private func makeHavingCell(from data: ChatroomListModel) -> [CellOfChatroomList] {
        var cells: [CellOfChatroomList] = []
        for chatroom in data.info {
            cells.append(CellOfChatroomList(chatroomList: chatroom))
        }
        
        //TODO: 채팅로그 구현되면 시간에 따라 sorting 필요
        
        return cells
    }
}

extension TableViewInChatroomList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = round(self.frame.height / 7.0)
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateForChatroomSelection?.chatroomCellTouched?(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastItem = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.item == lastItem {
            delegateForScrollAction?.loadNextPage()
        }
    }
}

extension TableViewInChatroomList : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.havingCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = havingCell[indexPath.row]
        return cell
    }
}
