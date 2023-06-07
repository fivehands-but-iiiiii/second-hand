//
//  TabBarItem.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

enum TabBarItemType: String {
    case home = "홈화면"
    case saleLog = "판매내역"
    case wishlist = "관심목록"
    case chat = "채팅"
    case myAccount = "내 계정"
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .saleLog:
            return UIImage(systemName: "newspaper")
        case .wishlist:
            return UIImage(systemName: "heart")
        case .chat:
            return UIImage(systemName: "message")
        case .myAccount:
            return UIImage(systemName: "person")
        }
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: rawValue, image: image, tag: hashValue)
    }
}

class TabBarItems {
    static func setItems() -> [UITabBarItem] {
        return [
            TabBarItemType.home.tabBarItem,
            TabBarItemType.saleLog.tabBarItem,
            TabBarItemType.wishlist.tabBarItem,
            TabBarItemType.chat.tabBarItem,
            TabBarItemType.myAccount.tabBarItem
        ]
    }
}
