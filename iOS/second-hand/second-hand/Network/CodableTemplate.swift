//
//  Gituser.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation

struct LoginFetchedUserData: Codable {
    let id: Int
    let memberId: String
    let profileImgUrl: String
    let oauth: String?
    let regions : [Region]
}

struct Region: Codable {
    let id : Int
    let onFocus : Bool
}

struct GitUserNeedsJoin: Codable {
    let id: String
    let login: String // GitUserLogin 의 memberid가 됨
    let avatar_url: String //GitUserLogin 의 profileImgUrl가 됨
}

struct GitUserJoinDTO: Codable  {
    let errorInfo: String?
    let message: String
    let body: GitUserNeedsJoin
}

struct LoginSuccess: Codable  {
    let message: String
    let data: LoginFetchedUserData
}

struct JoinSuccess: Codable {
    let message: String
    let data: Int
}

struct UserNeedsJoinRegisterRequest: Codable {
    let memberId: String
    let profileImgUrl: String
    let regions: [Region]
}

struct ResponseHeader: Codable {
    let setCookie: String
    
    enum CodingKeys: String, CodingKey {
        case setCookie = "Set-Cookie"
    }
}


//--------------------------------해당하는 지역의 상품을 볼 수 있다.--------------------------------
struct ItemList: Codable {
    let number: Int
    let hasPrevious, hasNext: Bool
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let title: String
    let thumbnailUrl: String?
    let region: ProductRegion
    let createdAt: String
    let price, status, hits, chatCount,likeCount: Int
    let isLike: Bool
}

// MARK: - Region
struct ProductRegion: Codable {
    let id: Int
    let city: String
    let county: String
    let district: String
}

//메세지를 보낼 수 있다.
struct SendMessage: Codable {
    let roomId: String
    let from: String
    let message: String
}

//사용자는 아이템에 대한 채팅방 정보를 알 수 있다.
struct ItemChatting: Codable {
    let opponentId: String
    let item: [ItemInfo]
    let chatId: Int?
}

struct ItemInfo: Codable {
    let itemId: Int
    let title: String
    let price: Int
    let thumbnailImgUrl: String
    let status: Int
}
