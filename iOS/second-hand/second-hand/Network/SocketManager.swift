//
//  StompClient.swift
//  second-hand
//
//  Created by SONG on 2023/07/18.
//

import Foundation
import StompClientLib

class SocketManager {
    var socketClient: StompClientLib
    
    init() {
        socketClient = StompClientLib()
    }
    
    func connect() {
        let socketURL = NSURL(string: "YOUR_SOCKET_URL")!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: socketURL as URL), delegate: self)
    }
    
    func disconnect() {
        socketClient.disconnect()
    }
    
}

extension SocketManager : StompClientLibDelegate {
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket connected")
        socketClient.subscribe(destination: "/your/destination/topic")
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
