//
//  StompManager.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/11.
//

import StompClientLib

class StompManager {
    
    
    var socketClient = StompClientLib()
    let url = NSURL(string: "ws://localhost:8080/chat")!
    var intervalSec = 1.0
    
    let messagePayload: [String: Any] = [
        "content": "Hello, World!",
        "sender": "John Doe"
    ]

    let destination = "/pub/chat/message"
    
    func registerSocket() {
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    
    func subscribe() {
        //특정topic(Destination)을 구독하는 함수
        if socketClient.isConnected() {
            socketClient.subscribe(destination: "구독할토픽")
        }
    }
    
    func sendMessage() {
            //var payloadObject : [String : Any] = [ Key 1 : Value 1 , ... , Key N, Value N ]
        
//            socketClient.sendJSONForDict(
//                            dict: payloadObject as AnyObject,
//                            toDestination: "[publish prefix]/[publish url]")
        
        //ex) toDestination: "/pub/chat/message"
        }
    
    func disconnect() {
        socketClient.disconnect()
    }

    
    
    func sendMessage(payloadObject: [String: Any], destination: String) {
        if socketClient.isConnected() {
            socketClient.sendJSONForDict(
                dict: payloadObject as AnyObject,
                toDestination: destination
            )
        }
    }
    
}

extension StompManager: StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print(#function)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print(#function)
        
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print(#function)
        //원하는 토픽 구독
        subscribe()
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print(#function)
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print(#function)
    }
    
    func serverDidSendPing() {
        print(#function)
    }
    
}


