//
//  Server.swift
//  second-hand
//
//  Created by SONG on 2023/06/23.
//

import Foundation

struct Server {
    static let shared = Server()
    static let baseURL = "http://3.37.51.148:81"
    static let oAuthURL = "https://github.com/login/oauth/authorize"
    static let clientID = "5c4b10099c0ae232e5a1"
    static let redirectURL = "http://localhost:5173/login/oauth2/code/github"

    enum Path: String {
        case join = "/join"
        case gitLogin = "/git/login"
        case login = "/login"
        case items = "/items"
        case wishlist = "/wishlist"
        case wishlistLike = "/wishlist/like"
        case wishlistCategories = "/wishlist/categories"
        case chats = "/chats"
    }

    func url(for path: Path) -> String {
        return Server.baseURL + path.rawValue
    }
    
    func url(path: Path, query: Query, queryValue: Int) -> String {
        return Server.baseURL + path.rawValue + "?" + query.rawValue + String(queryValue)
    }

    func gitLoginURL(withCode code: String) -> String {
        let query = Server.Query.code.rawValue + code
        return Server.baseURL + Path.gitLogin.rawValue + "?" + query
    }

    func oAuthAuthorizeURL() -> String {
        let query = "client_id=\(Server.clientID)&redirect_url=\(Server.redirectURL)"
        return Server.oAuthURL + "?" + query
    }
    
    func itemsListURL(page: Int, regionID: Int) -> String {
        let query = Server.Query.page.rawValue + "\(page)" + "&" + Server.Query.region.rawValue + "\(regionID)"
        return Server.baseURL + Path.items.rawValue + "?" + query
    }
    
    func wishItemListURL(page: Int) -> String {
        let query = Server.Query.page.rawValue + "\(page)" 
        return Server.baseURL + Path.wishlist.rawValue + "?" + query
    }
    
    func wishItemListCategoryURL(page: Int, categoryValue: Int) -> String {
        let query = Server.Query.page.rawValue + "\(page)" + "&" + Server.Query.category.rawValue + "\(categoryValue)"
        return Server.baseURL + Path.wishlist.rawValue + "?" + query
    }
    
    func itemDetailURL(itemId: Int) -> String {
        return Server.baseURL + Path.items.rawValue + "/" + String(itemId)
    }
    
    func requestIsExistChattingRoom(itemId: Int) -> String {
        return Server.baseURL + Path.chats.rawValue + Path.items.rawValue + "/" + String(itemId)
    }
    
    func requestToCreateChattingRoom() -> String {
        return Server.baseURL + Path.chats.rawValue
    }
    
    enum Query: String {
        case code = "code="
        case page = "page="
        case region = "regionId="
        case itemId = "itemId="
        case category = "category="
    }
}

