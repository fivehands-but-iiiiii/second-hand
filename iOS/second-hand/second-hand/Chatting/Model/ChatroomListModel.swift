//
//  ChatroomListModel.swift
//  second-hand
//
//  Created by SONG on 2023/08/13.
//

import Foundation

class ChatroomListModel: Updatable {
    var info : [ChatroomList] = []
    
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
        guard let response = fetchedData as? ChatroomList else{
            print("캐스팅실패")
            return
        }
        self.info.append(response)
    }
}
