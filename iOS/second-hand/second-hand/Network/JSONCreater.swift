//
//  JSONCreater.swift
//  second-hand
//
//  Created by SONG on 2023/06/17.
//

import Foundation

class JSONCreater {
    func createJSON(user: GitUserNeedsJoin, region: Region) -> Data? {
        
        let userData = GitUserNeedsJoinRegisterRequest(memberId: user.login, profileImgUrl: user.avatar_url, regions: [region])

        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(userData)
            print(String(data: jsonData, encoding: .utf8))
            return jsonData
        } catch {
            print("JSON encoding error: \(error)")
            return nil
        }
    }
}
