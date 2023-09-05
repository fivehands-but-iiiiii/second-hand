//
//  ButtonActionDelegate.swift
//  second-hand
//
//  Created by SONG on 2023/07/19.
//

import Foundation

@objc protocol ButtonActionDelegate {
    @objc optional func requestForChattingRoom()
    @objc optional func likeButtonTouched()
    @objc optional func backButtonTouched()
    @objc optional func sendButtonTouched(message: String)
    @objc optional func chatroomCellTouched(index: Int)
    @objc optional func setRegionButtonTouched()
    @objc optional func homeRightBarButtonTapped()
}
