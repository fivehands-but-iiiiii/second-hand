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
    
}

extension TableViewInChatroomList : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CellOfChatroomList.init(style: .default, reuseIdentifier: CellOfChatroomList.identifier)
    }
    
    
}
