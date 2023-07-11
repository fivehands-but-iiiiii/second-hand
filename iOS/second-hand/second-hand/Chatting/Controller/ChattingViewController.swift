//
//  ChattingViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//

import UIKit

final class ChattingViewController: NavigationUnderLineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
