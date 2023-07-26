//
//  StompClient.swift
//  second-hand
//
//  Created by SONG on 2023/07/18.
//

import Foundation
import StompClientLib

class SocketManager {
    var socketClient = StompClientLib()
    private var roomId: String? = nil
    private var message : Data? = nil
    init() {
        
    }
    
    func connect(roomId: String, memberId: String, message: String) {
        self.roomId = roomId
        let socketURL = NSURL(string: "ws://3.37.51.148:81/chat")!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: socketURL as URL), delegate: self)
        
        self.message = JSONCreater().createWSMessageRequestBody(roomId: roomId, memberId: memberId, message: message)
        
        if socketClient.isConnected() {
            stompClientDidConnect(client: self.socketClient)
        }
        
    }
    
    private func makeRequestForm(roomId: String, memberId: String, message: String) {
        
    }
    
    func disconnect() {
        socketClient.disconnect()
        //unsubscribe는 disconnect 이전에 한번 해주자.
    }
    

    
}

extension SocketManager : StompClientLibDelegate {
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket connected")
        guard let roomId = self.roomId else {
            return
        }
        
        
        
        socketClient.subscribe(destination: "/sub/\(roomId)")

        let destination = "/pub/message"
        
        guard let message = self.message else {
            return
        }
        
        guard let messageText = String(data:message,encoding: .utf8) else {
            return
        }
        
        guard let loginToken = UserInfoManager.shared.loginToken else {
            return
        }
        
        socketClient.sendMessage(message: messageText, toDestination: destination, withHeaders:nil , withReceipt: nil)

    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket disconnected")
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String: String]?, withDestination destination: String) {
        if let messageBody = jsonBody {
            print("Received JSON message: \(messageBody)")
        }
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Server sent receipt with ID: \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Server sent error: \(description)")
    }
    
    func serverDidSendPing() {
        print("Server sent ping")
    }
    
}
