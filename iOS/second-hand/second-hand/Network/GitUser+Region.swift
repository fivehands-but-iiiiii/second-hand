//
//  Gituser.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation

struct GitUserLogin: Codable {
    let id: String
    let memberId: String
    let profileImgUrl: String
    let region : [Region]
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

struct GitUserLoginDTO: Codable  {
    let errorInfo: String
    let message: String
    let body: GitUserLogin
}

struct GitUserNeedsJoinRegisterRequest: Codable {
    let memberId: String
    let profileImgURL: String
    let regions: [Region]
}
