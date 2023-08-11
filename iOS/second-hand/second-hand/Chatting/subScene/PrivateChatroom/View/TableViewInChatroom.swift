//
//  TableViewInChatroom.swift
//  second-hand
//
//  Created by SONG on 2023/07/30.
//

import UIKit

class TableViewInChatroom: UITableView {
    private var havingBubbles : [BubbleCell] = []
    private var cellHeight : [CGFloat] = []
    private var didScrollToLastCell = false
    
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
                calculateTextBoxHeight(for: .systemFont(ofSize: 17.0), text: item.message, maxWidth: Utils.screenWidth() * 0.7)
            }
        }
        return cells
    }
    
    private func calculateTextBoxHeight(for font: UIFont, text: String, maxWidth: CGFloat){
        let boundingSize = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingRect = text.boundingRect(with: boundingSize, options: options, attributes: attributes, context: nil)
        
        cellHeight.append(ceil(boundingRect.height))
    }
    
    func addMyBubbleAfterSending(_ message: ChatSendingSuccess) {
        let newBubble = MyCell(text: message.message)
        
        havingBubbles.append(newBubble)
        
        calculateTextBoxHeight(for: .systemFont(ofSize: 17.0), text: message.message, maxWidth: Utils.screenWidth() * 0.7)
        
        let indexPath = IndexPath(row: havingBubbles.count - 1, section: 0)
        self.insertRows(at: [indexPath], with: .automatic)
        
        scrollToLastCell(animated: true)
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
    
    private func scrollToLastCellIfNeeded() {
        if !didScrollToLastCell {
            scrollToLastCell(animated: true)
            didScrollToLastCell = true
        }
    }
}

extension TableViewInChatroom : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight[indexPath.item] + 40.0
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
        scrollToLastCellIfNeeded()
    }
}
