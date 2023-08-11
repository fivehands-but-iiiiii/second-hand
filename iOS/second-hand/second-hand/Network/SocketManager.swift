//
//  StompClient.swift
//  second-hand
//
//  Created by SONG on 2023/07/18.
//

import Foundation
import StompClientLib
import SwiftStomp

class SocketManager {
    var socketClient : SwiftStomp?
    private var roomId: String
    private var sender: String
    weak var delegate : SocketActionDelegate?
    
    init(roomId: String, sender: String) {
        self.roomId = roomId
        self.sender = sender
        
        guard let socketURL = URL(string: "ws://3.37.51.148:81/chat") else {
            return
        }
        
        guard let loginToken = UserInfoManager.shared.loginToken else {
            return
        }
        
        self.socketClient = SwiftStomp(host: socketURL)
        self.socketClient?.delegate = self
        self.socketClient?.autoReconnect = true
        self.socketClient?.enableLogging = true
        self.socketClient?.connect(loginToken: loginToken)
        
    }
    
    func send(_ message: String) {
        guard let body = JSONCreater().createWSMessageRequestBody(roomId: self.roomId, sender: self.sender, message: message) else {
            return
        }
        
        let header = ["content-type":"application/json;charset=UTF-8"]
        
        let bodyToSend = removeBackslashes(from: String(data: body, encoding: .utf8)!)
        socketClient?.send(body:bodyToSend, to: "/pub/message",headers: header)
        
    }
    
    private func makeRequestForm(roomId: String, memberId: String, message: String) {
        
    }
    
    func disconnect() {
        socketClient?.disconnect()
        //unsubscribe는 disconnect 이전에 한번 해주자.
    }
}

extension SocketManager : SwiftStompDelegate {
    
    func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
        print("소켓열림")
        socketClient?.subscribe(to: "/sub/\(self.roomId)")
    }
    
    func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
        print("소켓닫힘")
    }
    
    func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
        guard let delegate = delegate else {
            return
        }
        
        guard let message = message as? String else {
            return
        }
        
        let jsonData = message.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let myBubbleData = try decoder.decode(ChatSendingSuccess.self, from: jsonData)
            delegate.didSendMessage?(myBubbleData.message)
            
        } catch {
            
            do {
                let yourBubbleData = try decoder.decode(ChatBubbles.self, from: jsonData)
                delegate.didReceiveMessage?(yourBubbleData.message)
            } catch {
                print("디코딩 에러: \(error)")
            }
        }
    }
    
    func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
        print("영수증")
    }
    
    func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
        print(briefDescription)
        print(fullDescription ?? "")
    }
    
    func onSocketEvent(eventName: String, description: String) {
        print(eventName)
        print(description)
    }
    
    func removeBackslashes(from jsonString: String) -> String {
        let pattern = #"\\(.{1})"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: jsonString.utf16.count)
        
        return regex.stringByReplacingMatches(in: jsonString, options: [], range: range, withTemplate: "$1")
    }
    
}


