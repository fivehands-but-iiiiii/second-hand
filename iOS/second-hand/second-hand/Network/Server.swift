//
//  Server.swift
//  second-hand
//
//  Created by SONG on 2023/06/23.
//

import Foundation

struct Server {
    static let shared = Server()
    static let baseURL = "http://43.202.132.236:81"
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
        case resourceCategories = "/resources/categories"
        case itemsMine = "/items/mine"
        case status = "/status"
        case itemsImage = "/items/image"
        case logs = "/logs"
        case subscribe = "/subscribe"
        case regions = "/regions"
        case changeRegion = "/members/region"
        
    }
    
    func url(for path: Path) -> String {
        return Server.baseURL + path.rawValue
    }
    
    func url(path: Path, query: Query, queryValue: Int) -> String {
        return Server.baseURL + path.rawValue + "?" + query.rawValue + String(queryValue)
    }
    
    func urlBoolType(path: Path, query: Query, queryValue: Bool, page: Int) -> String {
        return Server.baseURL + path.rawValue + "?" + query.rawValue + String(queryValue) + "&" + Query.page.rawValue + "\(page)"
    }
    
    func gitLoginURL(withCode code: String) -> String {
        let query = Server.Query.code.rawValue + code + "&env=LOCAL"
        return Server.baseURL + Path.gitLogin.rawValue + "?" + query
    }
    
    func oAuthAuthorizeURL() -> String {
        let query = "client_id=\(Server.clientID)&redirect_url=\(Server.redirectURL)"
        return Server.oAuthURL + "?" + query
    }
    
    func itemsListURL(page: Int, regionID: Int, category: Int?) -> String {
        var query = Server.Query.page.rawValue + "\(page)" + "&" + Server.Query.region.rawValue + "\(regionID)"
        
        if let categoryData = category {
            query = query + "&" + Server.Query.categoryId.rawValue + "\(categoryData)"
        }
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
    
    func changeItemStatusUrl(for path: Path, id: Int, status: Path) -> String {
        return Server.baseURL + path.rawValue + "/\(id)" + status.rawValue
        
    }
    
    func requestToChattingLog(roomId: String, page: Int) -> String {
        let baseURL = Server.baseURL
        let chatsPath = Path.chats.rawValue
        let logsPath = Path.logs.rawValue
        let pageQuery = Query.page.rawValue + String(page)
        
        let url = baseURL + chatsPath + "/" + roomId + logsPath + "?" + pageQuery
        
        return url
    }
    
    func createRequestURLToChatroomList(page:Int, itemId:Int?) -> String {
        
        let baseURL = Server.baseURL
        let chatsPath = Path.chats.rawValue
        let pageQuery = Query.page.rawValue
        let itemIdQuery = Query.itemId.rawValue
        
        guard let itemId = itemId else {
            let url = baseURL + chatsPath + "?" + pageQuery + String(page)
            
            return url
        }
        
        let url = baseURL + chatsPath + "?" + pageQuery + String(page) + "&" + itemIdQuery + String(itemId)
        return url
    }
    
    func createDeletingChatroomURL(from chatroomId:String) -> String {
        let baseURL = Server.baseURL
        let chatsPath = Path.chats.rawValue
        
        let url = baseURL + chatsPath + "/\(chatroomId)"
        
        return url
    }
    
    func createSSESubscribeURL() -> String {
        let baseURL = Server.baseURL
        let chatsPath = Path.chats.rawValue
        let subscribePath = Path.subscribe.rawValue
        
        let url = baseURL + chatsPath + subscribePath
        return url
    }
    
    func createRegionListURL(keyword:String?) -> String {
        let baseURL = Server.baseURL
        let path = Path.regions.rawValue
        guard let keyword = keyword else {
            return baseURL + path
        }
        let query = Query.keyword.rawValue
        return baseURL + path + "?" + query + keyword
    }
    
    func createChangeRegionURL() -> String {
        let baseURL = Server.baseURL
        let path = Path.changeRegion.rawValue
        
        return baseURL + path
    }
    
    enum Query: String {
        case code = "code="
        case page = "page="
        case region = "regionId="
        case itemId = "itemId="
        case category = "category="
        case categoryId = "categoryId="
        case isSales = "isSales="
        case keyword = "keyword="
    }
}

