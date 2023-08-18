//
//  ChattingViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//

import UIKit

final class ChattingViewController: NavigationUnderLineViewController {
    private var chatroomListTableView : TableViewInChatroomList? = nil
    private var chatroomListModel = ChatroomListModel()
    private var currentPage = 0
    private var isLastPage = false
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
        showTabBar()
        setupList(isInitialize: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "채팅"
    }
    
    private func showNavigationBar() {
        if self.navigationController?.navigationBar.isHidden == true {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    private func showTabBar() {
        if self.tabBarController?.tabBar.isHidden == true {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
        if !UserInfoManager.shared.isLogOn {
            
        } else {
            fetchChatroomListData()
        }
    }
    
    private func fetchChatroomListData() {
        guard let url = URL(string: Server.shared.createRequestURLToChatroomList(page: 0, itemId: 199)) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: ChatroomListSuccess.self, what: nil, fromURL: url) { (result: Result<[ChatroomListSuccess], Error>) in
            switch result {
            case .success(let response) :
                guard let chatroomListPage = response.last?.chatRooms else {
                    return
                }
                self.chatroomListModel.updateData(from: chatroomListPage)
                //chatroomListModel.info[index] index가 page 넘버
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func makeTableView() {
        self.chatroomListTableView = TableViewInChatroomList(frame: .zero)
        print
    }
}
