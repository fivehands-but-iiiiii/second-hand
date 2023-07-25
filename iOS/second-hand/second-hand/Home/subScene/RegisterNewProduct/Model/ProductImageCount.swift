//
//  CountPicture.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import Foundation

struct ProductImageCount {
    var number = 0
    
    mutating func addImage() {
        number += 1
    }
    
    mutating func removeImage() {
        number -= 1
    }
}
