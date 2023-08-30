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
                        completion()
                    }
                }
            }
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
                
                if response.data.chatroomId == nil || response.data.opponentId == UserInfoManager.shared.userInfo?.memberId {
                    completion(false)
                    return
                } else {
                    completion(true)
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
                completion(false)
                return
            }
        }
    }
}
