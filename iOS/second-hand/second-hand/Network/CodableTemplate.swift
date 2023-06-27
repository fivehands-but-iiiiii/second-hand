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
struct ProductList: Codable {
    let number: Int
    let hasPrevious, hasNext: Bool
    let items: [ProductItem]
}

// MARK: - Item
struct ProductItem: Codable {
    let id: Int
    let title: String
    let thumbnailURL: String?
    let region: ProductRegion
    let createdAt: Date
    let price, status, hits, chatCount: Int
    let likeCount: Int
    let isLike: Bool
}

// MARK: - Region
struct ProductRegion: Codable {
    let id: Int
    let city: City
    let county: County
    let district: District
}

enum City: Codable {
    case 대구광역시
    case 오스트리아
    case 제주도
}

enum County: Codable {
    case 나니시
    case 달서구
    case 이린시
}

enum District: Codable {
    case 듀이동
    case 릴리동
    case 월성2동
}

