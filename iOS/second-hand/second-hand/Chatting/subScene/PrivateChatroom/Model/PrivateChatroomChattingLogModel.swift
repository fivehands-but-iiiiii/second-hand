//
//  PrivateChatroomChattingLogModel.swift
//  second-hand
//
//  Created by SONG on 2023/08/01.
//

import Foundation

class PrivateChatroomChattingLogModel: Updatable {
    var info : [ChattingLogPage] = []
    
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
        guard let response = fetchedData as? ChattingLogPage else{
            print("캐스팅실패")
            return
        }
        self.info.append(response)
    }
}
