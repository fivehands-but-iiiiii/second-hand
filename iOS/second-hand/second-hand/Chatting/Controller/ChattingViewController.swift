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
        setTableView()
        layout()
        self.navigationItem.title = "채팅"
        
        let stompManager = StompManager()
        stompManager.registerSocket() // 소켓 등록
        
        // 메시지 보내기
        let messagePayload: [String: Any] = [
            "content": "333",
            "sender": "John Doe"
        ]
        let destination = "/pub/chat/message"
        stompManager.sendMessage(payloadObject: messagePayload, destination: destination)
        
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
