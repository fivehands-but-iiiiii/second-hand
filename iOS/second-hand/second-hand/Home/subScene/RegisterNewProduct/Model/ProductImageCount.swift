//
//  CountPicture.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/22.
//

import Foundation

struct ProductImageCount {
    static var number = 0
    
    static func addImage() {
        self.number += 1
    }
    
    static func removeImage() {
        self.number -= 1
    }
}
