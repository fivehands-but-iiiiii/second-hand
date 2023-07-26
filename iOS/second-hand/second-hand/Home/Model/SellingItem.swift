//
//  Product.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/28.
//

import UIKit

struct SellingItem: Hashable {
    
    var id : Int
    var thumbnailImageUrl : String
    var title: String
    var price: Int
    var region: String
    var createdAt: String
    var chatCount : Int
    var likeCount : Int
    var status : Int
    
}
