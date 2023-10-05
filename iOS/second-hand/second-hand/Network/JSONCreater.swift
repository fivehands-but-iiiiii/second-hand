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
    static var headerValueContentTypeMultipart: String?
    static let blank = ""
    
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
    
    func createWSMessageRequestBody(roomId: String, sender: String, receiver: String, message: String) -> Data? {
        let requestBody: [String : String] = ["roomId":roomId,"sender":sender,"message":message]
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            return jsonData
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
    
    func createSSESubscribeBody() -> Data? {
        guard let userInfo = UserInfoManager.shared.userInfo else {
            return nil
        }
        
        let requestBody: [String : String] = ["memberId":userInfo.memberId]
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            return jsonData
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
    func createChangingRegionBody(_ cellData:Region) -> Data? {
        
        guard let userID = UserInfoManager.shared.userInfo?.id else {
            return nil
        }

        var jsonData: [String: Any] = [
            "id": userID,
            "regions": [
                [
                    "id": cellData.id,
                    "district": cellData.district!,
                    "onFocus": cellData.onFocus
                ] as [String : Any]
            ]
        ]

        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonData)
            return requestBody
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
    
    private func removeBackslashes(from jsonString: String) -> String {
        let pattern = #"\\(.{1})"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: jsonString.utf16.count)
        
        return regex.stringByReplacingMatches(in: jsonString, options: [], range: range, withTemplate: "$1")
    }
}
