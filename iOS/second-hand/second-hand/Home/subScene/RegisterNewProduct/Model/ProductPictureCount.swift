//
//  CountPicture.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import Foundation

struct ProductPictureCount {
    var number = 0
    
    mutating func addPicture() {
        number += 1
    }
    
    mutating func removePicture() {
        number -= 1
    }
}
