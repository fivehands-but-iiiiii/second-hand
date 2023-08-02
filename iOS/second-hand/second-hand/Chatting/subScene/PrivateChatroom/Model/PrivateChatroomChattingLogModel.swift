//
//  PrivateChatroomChattingLogModel.swift
//  second-hand
//
//  Created by SONG on 2023/08/01.
//

import Foundation

class PrivateChatroomChattingLogModel: Updatable {
    var info : ChattingLog? = nil
    
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
        guard let data = fetchedData as? ChattingLog else{
            print("캐스팅실패")
            return
        }
        self.info = data
    }
}
