//
//  TableViewInChatrromList.swift
//  second-hand
//
//  Created by SONG on 2023/08/13.
//

import UIKit

class TableViewInChatroomList: UITableView {
    private var havingCell : [CellOfChatroomList] = []
    
    init(chatroomList:ChatroomListModel) {
        super.init(frame: .zero, style: .plain)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
