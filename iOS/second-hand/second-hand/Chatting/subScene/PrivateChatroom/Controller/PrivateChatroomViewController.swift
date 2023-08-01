//
//  ChattingRoomViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/19.
//

import UIKit

class PrivateChatroomViewController: UIViewController {
    private var backButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private var chatroomTitle: UILabel? = nil
    var privateChatroomModel = PrivateChatroomModel()
    private var itemSummary: ItemSummaryInChatroom? = nil
    private var socketManager : SocketManager? = nil
    private var bottomSectionView : BottomSectionInChatroom? = nil
    private var chatLogTableView : TableViewInChatroom? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        readyToWS()
    }
    
    private func commonInit() {
        self.view.backgroundColor = .systemBackground
        generateBackButton()
        generateMenuButton()
        generateBottomSectionView()
        setConstraintsBackButton()
        setConstraintsMenuButton()
        setConstraintsBottomSectionView()
        didUpdateModel()
    }
    
    private func readyToWS() {
        
        guard let roomId = privateChatroomModel.info?.chatroomId else {
            return
        }
        
        guard let sender = UserInfoManager.shared.userInfo?.memberId else {
            return
        }
        
        self.socketManager = SocketManager(roomId: roomId, sender: sender)
        //socketManager.sendTest(message: "안녕")
    }
    
    private func didUpdateModel() {
        setChatroomTitle()
        setItemSummary()
        setChatLogTableView()
    }
    
    private func setItemSummary() {
        guard let itemImageURL = privateChatroomModel.info?.item.thumbnailImgUrl else {
            return
        }
        
        guard let itemTitle = privateChatroomModel.info?.item.title else {
            return
        }
        
        guard let itemPrice = privateChatroomModel.info?.item.price else {
            return
        }
        
        self.itemSummary = ItemSummaryInChatroom(url: itemImageURL, title: itemTitle, price: itemPrice)
        
        setConstraintsItemSummary()
    }
    
    private func setConstraintsItemSummary() {
        
        guard let itemSummary = itemSummary else {
            return
        }
        
        self.view.addSubview(itemSummary)
        
        self.itemSummary?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                itemSummary.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 40.0),
                itemSummary.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                itemSummary.heightAnchor.constraint(equalToConstant: 100.0),
                itemSummary.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    
    // MARK: NavigationBar (Buttons , title)
    private func setChatroomTitle() {
        self.chatroomTitle = UILabel(frame: .zero)
        self.chatroomTitle?.text = privateChatroomModel.info?.opponentId
        
        self.chatroomTitle?.font = .systemFont(ofSize: 17.0, weight: .bold)
        self.chatroomTitle?.textAlignment = .center
        setConstraintsChatroomTitle()
    }
    
    private func bringButtonsToFront() {
        guard let backButton = self.backButton else {
            return
        }
        
        guard let menuButton = self.menuButton else {
            return
        }
        
        self.view.bringSubviewToFront(backButton)
        self.view.bringSubviewToFront(menuButton)
    }
    
    private func generateBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("뒤로", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        self.backButton = button
    }
    
    private func generateMenuButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action:#selector(menuButtonTouched), for: .touchUpInside)
        self.menuButton = button
        
    }
    
    private func setConstraintsBackButton() {
        guard let backButton = self.backButton else {
            return
        }
        
        self.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setConstraintsMenuButton() {
        guard let menubutton = self.menuButton else {
            return
        }
        
        self.view.addSubview(menubutton)
        
        menubutton.translatesAutoresizingMaskIntoConstraints = false
        
        menubutton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        menubutton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    private func setConstraintsChatroomTitle() {
        guard let chatroomTitle = self.chatroomTitle else {
            return
        }
        
        guard let backButton = self.backButton else {
            return
        }
        
        guard let text = chatroomTitle.text else {
            return
        }
        
        let width: CGFloat = round(CGFloat(text.count) * 15.0)
        
        self.view.addSubview(chatroomTitle)
        
        chatroomTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                chatroomTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                chatroomTitle.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
                chatroomTitle.widthAnchor.constraint(equalToConstant: width),
                chatroomTitle.heightAnchor.constraint(equalTo: backButton.heightAnchor)
            ]
        )
    }
    
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func backButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func menuButtonTouched() {
        
    }
    
    //MARK: BottomSection
    private func generateBottomSectionView() {
        self.bottomSectionView = BottomSectionInChatroom(frame: .zero)
        setConstraintsBottomSectionView()
    }
    
    private func setConstraintsBottomSectionView() {
        guard let bottomSectionView = bottomSectionView else {
            return
        }
        
        if !self.view.subviews.contains(bottomSectionView) {
            self.view.addSubview(bottomSectionView)
        }
        
        bottomSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                bottomSectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
                bottomSectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                bottomSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                bottomSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    
    //MARK: TableView
    
    private func setChatLogTableView() {
        generateChatLogTableView()
        setConstraintsChatLogTableView()
    }
    
    private func generateChatLogTableView() {
        self.chatLogTableView = TableViewInChatroom(frame: .zero, style: .plain)
    }
    
    private func setConstraintsChatLogTableView() {
        guard let chatLogTableView = chatLogTableView else {
            return
        }
        
        guard let itemSummary = itemSummary else {
            return
        }
        
        guard let bottomSectionView = bottomSectionView else {
            return
        }
        
        if !self.view.subviews.contains(chatLogTableView) {
            self.view.addSubview(chatLogTableView)
        }
        
        chatLogTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                chatLogTableView.topAnchor.constraint(equalTo: itemSummary.bottomAnchor),
                chatLogTableView.bottomAnchor.constraint(equalTo: bottomSectionView.topAnchor),
                chatLogTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                chatLogTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ]
        )
    }
}
