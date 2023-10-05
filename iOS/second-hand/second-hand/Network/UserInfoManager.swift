//
//  UserInfo.swift
//  second-hand
//
//  Created by SONG on 2023/06/22.
//

import Foundation
import RxSwift

class UserInfoManager: Updatable{
    static let shared = UserInfoManager()
    var userInfo: LoginFetchedUserData? = nil
    var isLogOn: Bool = false
    var loginToken: String? = nil
    
    let regionSubject = BehaviorSubject<Region>(value: Region(id: 2729060200, onFocus: true, district: "월성2동"))
    
    private let loginNotification = Notification(name: NSNotification.Name("LOGIN"))

    func updateData<T:Codable>(from fetchedData: T) {
        
        guard let data = fetchedData as? LoginFetchedUserData else {
            return
        }
        
        guard let region = data.regions.first else {
            return
        }
        self.userInfo = data
        isLogOn = true
        
        regionSubject.onNext(region)
        NotificationCenter.default.post(name: loginNotification.name, object: nil)
    }
    
    func loadRegion() -> Observable<Region> {
            return regionSubject.asObservable()
        }
}

