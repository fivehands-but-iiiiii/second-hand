//
//  ChatroomListModel.swift
//  second-hand
//
//  Created by SONG on 2023/08/13.
//

import Foundation

class ChatroomListModel: Updatable {
    func updateData<T>(from fetchedData: T) where T : Decodable, T : Encodable {
    }
    
    var info : [ChatroomList] = []
    
    func updateData<T>(from fetchedData: T, initialize: Bool, completion: @escaping () -> Void) where T: Decodable, T: Encodable {
        if initialize {
            self.info = []
        }
        guard let chatrooms = fetchedData as? [ChatroomList] else {
            print("캐스팅실패")
            return
        }
        var count = 0
        
        for chatroom in chatrooms {
            
            if chatroom.opponent.memberId != UserInfoManager.shared.userInfo?.memberId {
                isValidChatroom(chatroom: chatroom) { isValid in
                    if isValid {
                        self.info.append(chatroom)
                    }
                    count += 1
                    if count == chatrooms.count {
                        let sortedList = self.sortList(list: self.info)
                        self.info = sortedList
                        completion()
                    }
                }
            }
        }
    }
    
    private func sortList(list: [ChatroomList]) -> [ChatroomList] {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFractionalSeconds, .withDashSeparatorInDate, .withColonSeparatorInTime,.withFullDate,.withTime]
        
        if list.count <= 1 {
            return list
        } else {
            let sortedList = list.sorted { (chatroom1, chatroom2) in
                if let date1 = dateFormatter.date(from: chatroom1.lastUpdate), let date2 = dateFormatter.date(from: chatroom2.lastUpdate) {
                    return date1 > date2
                } else {
                    return false
                }
            }
            return sortedList
        }
    }
    private func isValidChatroom(chatroom: ChatroomList, completion: @escaping (Bool) -> Void) {
        let itemId = chatroom.item.itemId
        
        guard let url = URL(string: Server.shared.requestIsExistChattingRoom(itemId: itemId)) else {
            completion(false)
            return
        }
        
        guard let requestBody = JSONCreater().createOpenChatroomRequestBody(itemId: itemId) else {
            completion(false)
            return
        }
        
        NetworkManager.sendGET(decodeType: ChatroomSuccess.self,header: nil, body: nil, fromURL: url) { (result: Result<[ChatroomSuccess], Error>) in
            switch result {
            case .success(let reposonse) :
                guard let response = reposonse.last else {
                    completion(false)
                    return
                }
                completion(true)
            case .failure(let error) :
                print(error.localizedDescription)
                completion(false)
                return
            }
        }
    }
}
