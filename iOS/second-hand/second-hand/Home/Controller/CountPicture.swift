//
//  CountPicture.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import Foundation

struct CountPicture {
    var picture = 0
    
    mutating func addPicture() {
        picture += 1
    }
    
    mutating func removePicture() {
        picture -= 1
    }
}
