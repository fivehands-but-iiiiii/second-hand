//
//  PrivateChatroomData.swift
//  second-hand
//
//  Created by SONG on 2023/07/24.
//

import Foundation

class PrivateChatroomModel: Updatable {
    var info : ChatroomData? = nil
    
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
        guard let data = fetchedData as? ChatroomData else{
            print("캐스팅실패")
            return
        }
        
        self.info = data
    }
}
