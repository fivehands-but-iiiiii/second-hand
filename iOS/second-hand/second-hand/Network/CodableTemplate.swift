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
struct ItemListSuccess: Codable {
    let message : String
    let data : ItemList
}

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

struct ItemDetailInfoSuccess: Codable {
    let message : String
    let data : ItemDetailInfo
}

struct ItemDetailInfo: Codable {
    let id: Int
    let title: String
    let contents: String
    let category: Int
    let price: Int
    let status: Int
    let seller: Seller
    let isMyItem: Bool
    let images: [ItemDetailImage]
    let hits: Int
    let chatCount: Int
    let likesCount: Int
    var isLike: Bool
    let createAt: String
}

struct Seller: Codable {
    let id: Int
    let memberId: String
}

struct ItemDetailImage: Codable {
    let url: String
}


struct LikeResponseMessage : Codable {
    let message: String
    let data: Int
}

struct UnlikeResponseMessage : Codable {
    let message: String
    let data: String
}

struct CommonAPIResponse: Codable {
    let message: String
    let data: String
}


struct WishItemList: Codable {
    let message: String
    let data: WishItemData
}

struct WishItemData: Codable {
    let page: Int
    let hasPrevious: Bool
    let hasNext: Bool
    let items: [WishItem]
}

struct WishItem: Codable {
    let id: Int
    let title: String
    let thumbnailUrl: String
    let region: String
    let createdAt: String
    let status: Int
    let price, chatCount,likeCount: Int
}

struct GetCategories: Codable {
    let message: String
    let data: Categories
}

struct Categories: Codable {
    let categories: [Int]
}


struct CategoryData: Codable {
    let message: String
    let data: CategoryContainer
}

struct CategoryContainer: Codable {
    let categories: [CategoryElement]
}

struct CategoryElement: Codable {
    let id: Int
    let title: String
    let iconUrl: String
}

//MARK: ChatRoom
struct ItemOfChatroom: Codable {
    let itemId: Int
    let title: String
    let price: Int
    let thumbnailImgUrl: String
    let status: Int
    let isDelete: Bool
}

struct ChatroomData: Codable {
    let chatroomId: String?
    let opponentId: String
    let isOpponentIn: Bool
    let item: ItemOfChatroom
}

struct ChatroomSuccess: Codable {
    let message: String
    let data: ChatroomData
}
//MARK: ChattingLog
struct ChattingLog: Codable {
    let message : String
    let data : ChattingLogPage
}

struct ChattingLogPage: Codable {
    let hasPre: Bool
    let hasNext: Bool
    let chatBubbles : [ChatBubbles]
}

struct ChatBubbles: Codable {
    let id : String
    let senderId: String
    let message: String
    let isMine: Bool
    let createdAt: String
}

struct ChatSendingSuccess: Codable {
    let id : String
    let roomId: String
    let sender: String
    let message: String
    let createdAt: String
}

// MARK: ChatroomList

struct ChatroomListSuccess: Codable {
    let page : Int
    let hasPrevious : Bool
    let hasNext : Bool
    let chatRooms : [ChatroomList]
}

struct ChatroomList: Codable {
    let chatroomId : String
    let opponent : ChatroomListOpponent
    let item : ChatroomListItem
    let chatLogs : ChatroomListChatLog
}

struct ChatroomListOpponent: Codable {
    let memberId : String
    let profileImgUrl : String
}

struct ChatroomListItem: Codable {
    let itemId : Int
    let title : String
    let thumbnailImgUrl: String
}

struct ChatroomListChatLog: Codable {
    let lastMessage: String
    let updatedAt : String
    let unReadCount: Int
}
