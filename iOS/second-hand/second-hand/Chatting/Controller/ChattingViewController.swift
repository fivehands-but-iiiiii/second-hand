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
    
    private func setupList(isInitialize: Bool) {
        if !UserInfoManager.shared.isLogOn {
            
        } else {
            fetchChatroomListData(isInitialize:isInitialize) {
                self.setupTableView()
            }
        }
    }
    
//    private func fetchChatroomListDataAndMakeTableView(completion: @escaping () -> Void) {
//        fetchChatroomListData {
//            completion()
//        }
//    }
    
    private func fetchChatroomListData(isInitialize: Bool, completion: @escaping () -> Void) {
        if isInitialize {
            self.isLastPage = false
            self.currentPage = 0
        }
        
        guard let url = URL(string: Server.shared.createRequestURLToChatroomList(page: currentPage, itemId: nil)) else {
            completion()
            return
        }
        
        NetworkManager.sendGET(decodeType: ChatroomListSuccess.self, what: nil, fromURL: url) { (result: Result<[ChatroomListSuccess], Error>) in
            switch result {
            case .success(let response) :
                guard let chatroomListPage = response.last?.data.chatRooms else {
                    return
                }
                
                if chatroomListPage.count == 0 {
                    self.isLastPage = true
                    return
                }
                
                self.chatroomListModel.updateData(from: chatroomListPage, initialize: isInitialize) {
                    completion()
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupTableView() {
        if self.chatroomListTableView != nil {
            self.chatroomListTableView?.removeFromSuperview()
        }
        self.chatroomListTableView = TableViewInChatroomList(chatroomList: chatroomListModel)
        setConstraintChatroomListTableView()
        chatroomListTableView?.delegateForChatroomSelection = self
        chatroomListTableView?.delegateForScrollAction = self
    }
    
    
    private func setConstraintChatroomListTableView() {
        guard let chatroomListTableView = self.chatroomListTableView else {
            return
        }
        
        if !self.view.contains(chatroomListTableView) {
            self.view.addSubview(chatroomListTableView)
        }
        
        chatroomListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                chatroomListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                chatroomListTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                chatroomListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                chatroomListTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
}
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
