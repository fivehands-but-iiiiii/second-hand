//
//  JSONCreater.swift
//  second-hand
//
//  Created by SONG on 2023/06/17.
//

import Foundation

class JSONCreater {
    static let headerKeyContentType = "Content-Type"
    static let headerValueContentType = "application/json"
    static let headerKeyAuthorization = "Authorization"
    
    func createGithubLoginRequestBody(user: GitUserNeedsJoin, region: Region) -> Data? {
        
        let userData = UserNeedsJoinRegisterRequest(memberId: user.login, profileImgUrl: user.avatar_url, regions: [region])
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(userData)
            
            return jsonData
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
    
    func createOpenChatroomRequestBody(itemId:Int) -> Data? {
        let requestBody: [String: Int] = ["itemId": itemId]
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            return jsonData
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
}
