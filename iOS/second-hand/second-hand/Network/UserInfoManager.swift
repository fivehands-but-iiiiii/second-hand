//
//  UserInfo.swift
//  second-hand
//
//  Created by SONG on 2023/06/22.
//

import Foundation

class UserInfoManager: Updatable{
    static let shared = UserInfoManager()
    var userInfo: LoginFetchedUserData? = nil
    var isLogOn: Bool = false
    
    private let loginNotification = Notification(name: NSNotification.Name("LOGIN"))

    
    func updateData<T:Codable>(from fetchedData: T) {
        
        guard let data = fetchedData as? LoginFetchedUserData else {
            return
        }
        self.userInfo = data
        isLogOn = true
        NotificationCenter.default.post(name: loginNotification.name, object: nil)
    }
}

