//
//  ImageCacheManager.swift
//  second-hand
//
//  Created by SONG on 2023/06/27.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    
}
