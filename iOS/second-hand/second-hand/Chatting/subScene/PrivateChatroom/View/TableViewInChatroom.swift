//
//  TableViewInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class TableViewInChatroom: UITableView {
//    private var bubbleCount = 0
//    private var sectionCount = 0
    private var havingBubbles : [BubbleCell] = []
    
    init(chattingLogData: PrivateChatroomChattingLogModel) {
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        registerCell()
        self.havingBubbles = makeHavingBubbles(from: chattingLogData)
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        registerCell()
    }
    
//    private func calculateNumberOfRows(from data : PrivateChatroomChattingLogModel) {
//        var sum = 0
//        for page in data.info {
//            sum += page.chatBubbles.count
//        }
//        self.bubbleCount = sum
//    }
//
//    private func calculateNumberOfSections(from data : PrivateChatroomChattingLogModel) {
//        self.sectionCount = data.info.count
//    }
    
    private func registerCell() {
        self.register(MyCell.self, forCellReuseIdentifier: MyCell.identifier)
        self.register(YourCell.self, forCellReuseIdentifier: YourCell.identifier)
    }
    
    private func makeHavingBubbles(from data : PrivateChatroomChattingLogModel) -> [BubbleCell] {
        var cells : [BubbleCell] = []
        for page in data.info {
            for item in page.chatBubbles {
                if item.isMine {
                    cells.append(MyCell(text: item.message))
                } else {
                    cells.append(YourCell(text: item.message))
                }
            }
        }
        return cells
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
        let rowHeight: CGFloat = 45 + 23.0 * CGFloat((havingBubbles[indexPath.row].textCount / 18))
        return rowHeight
    }
}

extension TableViewInChatroom : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return havingBubbles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return havingBubbles[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        scrollToLastCell(animated: true)
    }
    
}
