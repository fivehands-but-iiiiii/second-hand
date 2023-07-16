//
//  ItemDetailModel.swift
//  second-hand
//
//  Created by SONG on 2023/07/12.
//

import Foundation

class ItemDetailModel: Updatable {
    var info : ItemDetailInfo? = nil
    
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
        guard let data = fetchedData as? ItemDetailInfo else{
            print("캐스팅실패")
            return
        }
        self.info = data
    }
}
