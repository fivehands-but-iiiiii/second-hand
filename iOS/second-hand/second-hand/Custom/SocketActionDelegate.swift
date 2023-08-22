//
//  SocketActionDelegate.swift
//  second-hand
//
//  Created by SONG on 2023/08/06.
//

import Foundation

@objc protocol SocketActionDelegate {
    @objc optional func didReceiveMessage(_ message: String)
    @objc optional func didSendMessage(_ message: String)
}
