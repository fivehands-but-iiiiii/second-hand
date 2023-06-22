//
//  CountPicture.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import Foundation

struct ProductPicture {
    var count = 0
    
    mutating func addPicture() {
        count += 1
    }
    
    mutating func removePicture() {
        count -= 1
    }
}
