//
//  TableViewInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class TableViewInChatroom: UITableView {


}

extension TableViewInChatroom : UITableViewDelegate {
    
}

extension TableViewInChatroom : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: .zero)
    }
    
    
}
