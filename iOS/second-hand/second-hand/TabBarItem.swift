//
//  TabBarItem.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class TabBarItems {
    static let tabTitles : [String] = ["홈화면","판매내역","관심목록","채팅","내 계정"]
    static let tabImages : [UIImage?] = [UIImage(systemName:"house"),UIImage(systemName:"newspaper"),UIImage(systemName:"heart"),UIImage(systemName:"message"),UIImage(systemName:"person")]
    
    static func setItems() -> [UITabBarItem] {
        var items = [UITabBarItem]()
        
        for index in 0...4 {
            items.append(UITabBarItem(title: tabTitles[index], image: tabImages[index], tag: index))
        }
        return items
    }
}


