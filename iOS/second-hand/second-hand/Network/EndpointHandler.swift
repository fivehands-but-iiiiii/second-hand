//
//  Server.swift
//  second-hand
//
//  Created by SONG on 2023/06/23.
//

import Foundation

struct EndpointHandler {
    static let shared = EndpointHandler()
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
        case changeProfilePhoto = "/members/image"
    }
    
    func url(for path: Path) -> String {
        return EndpointHandler.baseURL + path.rawValue
    }
    
    func url(path: Path, query: Query, queryValue: Int) -> String {
        return EndpointHandler.baseURL + path.rawValue + "?" + query.rawValue + String(queryValue)
    }
    
    func urlBoolType(path: Path, query: Query, queryValue: Bool, page: Int) -> String {
        return EndpointHandler.baseURL + path.rawValue + "?" + query.rawValue + String(queryValue) + "&" + Query.page.rawValue + "\(page)"
    }
    
    func gitLoginURL(withCode code: String) -> String {
        let query = EndpointHandler.Query.code.rawValue + code + "&env=LOCAL"
        return EndpointHandler.baseURL + Path.gitLogin.rawValue + "?" + query
    }
    
    func oAuthAuthorizeURL() -> String {
        let query = "client_id=\(EndpointHandler.clientID)&redirect_url=\(EndpointHandler.redirectURL)"
        return EndpointHandler.oAuthURL + "?" + query
    }
    
    func itemsListURL(page: Int, regionID: Int, category: Int?) -> String {
        var query = EndpointHandler.Query.page.rawValue + "\(page)" + "&" + EndpointHandler.Query.region.rawValue + "\(regionID)"
        
        if let categoryData = category {
            query = query + "&" + EndpointHandler.Query.categoryId.rawValue + "\(categoryData)"
        }
        return EndpointHandler.baseURL + Path.items.rawValue + "?" + query
    }
    
    func wishItemListURL(page: Int) -> String {
        let query = EndpointHandler.Query.page.rawValue + "\(page)"
        return EndpointHandler.baseURL + Path.wishlist.rawValue + "?" + query
    }
    
    func wishItemListCategoryURL(page: Int, categoryValue: Int) -> String {
        let query = EndpointHandler.Query.page.rawValue + "\(page)" + "&" + EndpointHandler.Query.category.rawValue + "\(categoryValue)"
        return EndpointHandler.baseURL + Path.wishlist.rawValue + "?" + query
    }
    
    func itemDetailURL(itemId: Int) -> String {
        return EndpointHandler.baseURL + Path.items.rawValue + "/" + String(itemId)
    }
    
    func requestIsExistChattingRoom(itemId: Int) -> String {
        return EndpointHandler.baseURL + Path.chats.rawValue + Path.items.rawValue + "/" + String(itemId)
    }
    
    func requestToCreateChattingRoom() -> String {
        return EndpointHandler.baseURL + Path.chats.rawValue
    }
    
    func changeItemStatusUrl(for path: Path, id: Int, status: Path) -> String {
        return EndpointHandler.baseURL + path.rawValue + "/\(id)" + status.rawValue
        
    }
    
    func requestToChattingLog(roomId: String, page: Int) -> String {
        let baseURL = EndpointHandler.baseURL
        let chatsPath = Path.chats.rawValue
        let logsPath = Path.logs.rawValue
        let pageQuery = Query.page.rawValue + String(page)
        
        let url = baseURL + chatsPath + "/" + roomId + logsPath + "?" + pageQuery
        
        return url
    }
    
    func createRequestURLToChatroomList(page:Int, itemId:Int?) -> String {
        
        let baseURL = EndpointHandler.baseURL
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
        let baseURL = EndpointHandler.baseURL
        let chatsPath = Path.chats.rawValue
        
        let url = baseURL + chatsPath + "/\(chatroomId)"
        
        return url
    }
    
    func createSSESubscribeURL() -> String {
        let baseURL = EndpointHandler.baseURL
        let chatsPath = Path.chats.rawValue
        let subscribePath = Path.subscribe.rawValue
        
        let url = baseURL + chatsPath + subscribePath
        return url
    }
    
    func createRegionListURL(keyword:String?) -> String {
        let baseURL = EndpointHandler.baseURL
        let path = Path.regions.rawValue
        guard let keyword = keyword else {
            return baseURL + path
        }
        let query = Query.keyword.rawValue
        return baseURL + path + "?" + query + keyword
    }
    
    func createChangeRegionURL() -> String {
        let baseURL = EndpointHandler.baseURL
        let path = Path.changeRegion.rawValue
        
        return baseURL + path
    }
    
    func createChangeProfilePhotoURL() -> String {
        let baseURL = EndpointHandler.baseURL
        let path = Path.changeProfilePhoto.rawValue
        
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

