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
