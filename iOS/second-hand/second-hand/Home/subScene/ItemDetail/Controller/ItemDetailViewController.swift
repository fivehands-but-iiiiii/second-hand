//
//  ItemDetailViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/09.
//

import UIKit

protocol StatusButtonChange {
    func onsale(id: Int)
    func reservation(id: Int)
    func soldOut(id: Int)
}

//protocol BackButtonTouchedDelegate {
//    func backButtonTouched()
//}
enum LastViewController {
    case home
    case saleLog
}

class ItemDetailViewController: UIViewController {
    
    var delegate: ButtonActionDelegate? = nil
    private var backButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private var itemDetailURL: URL? = nil
    private var itemDetailModel = ItemDetailModel()
    private var imageSectionView: ItemDetailImageSectionView!
    var textSectionView = ItemDetailTextSectionView(frame: .zero)
    private var bottomSectionView = ItemDetailBottomSectionView(frame: .zero)
    private let networkManager = NetworkManager()
    var statusDelegate: StatusButtonChange?
    private let modifyItem = RegisterNewProductViewController()
    var lastViewController: LastViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItemDetailModel()
        initializeScene()
        bottomSectionView.delegate = self
        modifyItem.updateDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bringButtonsToFront()
    }
    
    func updateStatusDelegateIfNeeded() {
        if statusDelegate == nil {
            statusDelegate = SaleLogViewController()
        }
    }
    
    func lastViewControllerSet(what: LastViewController) {
        self.lastViewController = what
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
    
    private func initializeScene() {
        self.view.backgroundColor = .white
        hideNavigationBar()
        generateBackButton()
        generateMenuButton()
        setConstraintsBackButton()
        setConstraintsMenuButton()
    }
    
    func setItemDetailURL(_ url : String) {
        self.itemDetailURL = URL(string: url)
    }
    
    private func setItemDetailImagesURLToView() {
        guard let info = itemDetailModel.info else {
            return
        }
        var imageURLS : [String] = []
        for item in info.images {
            imageURLS.append(item.url)
        }
        imageSectionView = ItemDetailImageSectionView(images: imageURLS)
    }
    
    private func setItemDetailModel() {
        guard let url = self.itemDetailURL else {
            return
        }
        

        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.sendGET(decodeType: ItemDetailInfoSuccess.self,header: nil, body: nil, fromURL: url) { [weak self] (result: Result<[ItemDetailInfoSuccess], Error>) in
            guard let self = self else { return }
            
            defer {
                group.leave()
            }

            switch result {
            case .success(let data):
                guard let detailInfo = data.last else {
                    return
                }
                self.itemDetailModel.updateData(from: detailInfo.data)
                self.setImageSection()
                self.setTextSectionView()
                self.setBottomSectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            self.initializeScene()
        }
    }
    
    func likeButtonTouched() {
        guard let itemId = itemDetailModel.info?.id else {
            return
        }
        
        let jsonData: [String: Int] = ["itemId": itemId]
        
        if let isLike = itemDetailModel.info?.isLike {
            if isLike {
                guard let unwishlistLikeURL = URL(string: Server.shared.url(path: .wishlistLike, query: .itemId, queryValue: itemId)) else {
                    return
                }
                
                NetworkManager().sendDelete(decodeType: UnlikeResponseMessage.self, what: nil, fromURL: unwishlistLikeURL) { [weak self] (result: Result<UnlikeResponseMessage?, Error>) in
                    switch result {
                    case .success(let message):
                        print("찜 해제 성공  \(message)")
                        self?.updateLikeStatus(isLike: false)
                    case .failure(let error):
                        print("찜 해제 실패 \(error)")
                    }
                }
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonData)
                    
                    guard let wishlistLikeURL = URL(string: Server.shared.url(for: .wishlistLike)) else {
                        return
                    }
                    
                    networkManager.sendPOST(decodeType: IntData.self, what: jsonData, header: nil, fromURL: wishlistLikeURL) { [weak self] (result: Result<IntData, Error>) in
                        switch result {
                        case .success(let message):
                            print("찜 성공  \(message)")
                            self?.updateLikeStatus(isLike: true)
                        case .failure(let error):
                            print("찜 실패 \(error)")
                        }
                    }
                } catch {
                    print("Error encoding JSON data: \(error)")
                }
            }
        }
    }
    
    
    
    private func updateLikeStatus(isLike: Bool) {
        itemDetailModel.info?.isLike = isLike
        bottomSectionView.likeButton?.removeFromSuperview()
        bottomSectionView.setLikeButton(isLike: isLike)
        bottomSectionView.layoutIfNeeded()
    }
    
    
    private func InfoNotLogin() {
        print("로그인을 하세요")
    }
    
    // MARK: BUTTONS
    private func generateBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        self.backButton = button
    }
    
    private func generateMenuButton() {
        if itemDetailModel.info?.isMyItem == true {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            button.tintColor = .black
            button.addTarget(self, action:#selector(menuButtonTouched), for: .touchUpInside)
            self.menuButton = button
        }
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
    
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func backButtonTouched() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        delegate?.backButtonTouched?()
    }
    
    @objc private func menuButtonTouched() {
        guard let id = itemDetailModel.info?.id else {return}
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "게시글 수정", style: .default, handler: { [self] (ACTION:UIAlertAction) in
            guard let url = URL(string: Server.shared.itemDetailURL(itemId: id)) else {
                return
            }
            NetworkManager.sendGET(decodeType: ItemDetailInfoSuccess.self,header:nil,body: nil, fromURL: url) { [self] (result: Result<[ItemDetailInfoSuccess], Error>) in
                switch result {
                case .success(let data) :
                    guard let detailInfo = data.last?.data else {
                        return
                    }
                    
                    modifyItem.getItemInfo(title: detailInfo.title, price: detailInfo.price.comma(), contents: detailInfo.contents, images: detailInfo.images)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            present(UINavigationController(rootViewController: modifyItem), animated: true)
            modifyItem.updateId(id: id)
            //저기서 작업이 끝난다면 여기서 업데이트를 해줘야행
        }))
        
        actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (ACTION:UIAlertAction) in
            
            let url = URL(string: Server.shared.itemDetailURL(itemId: id))!
            deleteItem(url: url)
            self.navigationController?.popViewController(animated: true)
            tabBarController?.tabBar.isHidden = false
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func deleteItem(url: URL) {
        networkManager.sendDelete(decodeType: BooleanResponse.self, what: nil, fromURL: url) { (result: Result<BooleanResponse?, Error>) in
            switch result {
            case .success(let data):
                print("성공적으로 삭제되었습니다.")
                if data?.message != nil {
                    print(data!.message)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: IMAGE SECTION
    
    private func setImageSection() {
        setItemDetailImagesURLToView()
        setConstraintsImageSection()
    }
    
    private func setConstraintsImageSection() {
        self.view.addSubview(imageSectionView)
        
        imageSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                imageSectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
                imageSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                imageSectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
                imageSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    
    //MARK: TEXT SECTION
    private func setTextSectionView() {
        setTextSectionViewConstraints()
        
        guard let name = itemDetailModel.info?.seller.memberId else {
            return
        }
        textSectionView.setSellerInfoView(sellerName: name)
        
        guard let isMine = itemDetailModel.info?.isMyItem else {
            return
        }
        
        guard let status = itemDetailModel.info?.status else {
            return
        }
        textSectionView.setStatusButton(isMine: isMine, status: status)
        
        guard let title = itemDetailModel.info?.title else {
            return
        }
        
        guard let category = itemDetailModel.info?.category else {
            return
        }
        
        guard let createAt = itemDetailModel.info?.createAt else {
            return
        }
        
        guard let content = itemDetailModel.info?.contents else {
            return
        }
        
        guard let chatCount = itemDetailModel.info?.chatCount else {
            return
        }
        
        guard let likeCount = itemDetailModel.info?.likesCount else {
            return
        }
        
        guard let hits = itemDetailModel.info?.hits else {
            return
        }
        textSectionView.setContenetOfPost(title: title, category: category, createAt: createAt, content: content, chatCount: chatCount, likeCount: likeCount, hits: hits)
        self.textSectionView.statusButton.delegate = self
    }
    
    private func setTextSectionViewConstraints() {
        
        self.view.addSubview(textSectionView)
        
        textSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textSectionView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 10.0),
                textSectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
                textSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                textSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
    //MARK: BOTTOM SECTION
    private func setBottomSectionView() {
        setBottomSectionViewConstraints()
        
        guard let isLike = itemDetailModel.info?.isLike else {
            return
        }
        
        guard let price = itemDetailModel.info?.price else {
            return
        }
        
        guard let isMine = itemDetailModel.info?.isMyItem else {
            return
        }
        
        bottomSectionView.setLikeButton(isLike: isLike)
        bottomSectionView.setPriceLabel(price: price)
        bottomSectionView.setChattingRoomButton(isMine: isMine)
        bottomSectionView.delegate = self
    }
    
    private func setBottomSectionViewConstraints() {
        self.view.addSubview(bottomSectionView)
        
        bottomSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                bottomSectionView.topAnchor.constraint(equalTo: self.textSectionView.bottomAnchor),
                bottomSectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                bottomSectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                bottomSectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
    }
}

//MARK: ButtonActionDelegate

extension ItemDetailViewController : ButtonActionDelegate {
    func requestForChattingRoom() {
        if !UserInfoManager.shared.isLogOn {
            let alert = UIAlertController(title: "로그인 필요", message: "해당 기능을 사용하려면 로그인이 필요합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            guard let itemId = itemDetailModel.info?.id else {
                return
            }
            
            guard let url = URL(string: Server.shared.requestIsExistChattingRoom(itemId: itemId)) else {
                return
            }
            
            guard let requestBody = JSONCreater().createOpenChatroomRequestBody(itemId: itemId) else {
                return
            }
            
            NetworkManager.sendGET(decodeType: ChatroomSuccess.self,header: nil, body: nil, fromURL: url) { (result: Result<[ChatroomSuccess], Error>) in
                switch result {
                case .success(let reposonse) :
                    guard let response = reposonse.last else {
                        return
                    }
                    
                    if let chatRoomId = response.data.chatroomId {
                        print("채팅방입장")
                        self.changeToChatroomViewController(fetchedData: response)
                        
                    } else {
                        print("채팅방생성")
                        self.createChattingRoom(body: requestBody)
                    }
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    private func enterChattingRoom(chatroomId: String) {
        guard let url = URL(string: Server.baseURL + "/chats/" + chatroomId ) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: ChatroomSuccess.self,header: nil, body: nil, fromURL: url) { (result: Result<[ChatroomSuccess], Error>) in
            switch result {
            case .success(let response) :
                guard let response = response.last else {
                    return
                }
                
                self.changeToChatroomViewController(fetchedData: response)
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func createChattingRoom(body: Data) {
        guard let url = URL(string: Server.shared.requestToCreateChattingRoom()) else {
            return
        }
        
        NetworkManager().sendPOST(decodeType: CommonAPIResponse.self, what: body, header: nil,  fromURL: url ){ (result: Result<CommonAPIResponse, Error>) in
            switch result {
            case .success(let response) :
                self.enterChattingRoom(chatroomId: response.data)
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    private func changeToChatroomViewController(fetchedData: ChatroomSuccess) {
        let privateChatroom = PrivateChatroomViewController()
        
        privateChatroom.privateChatroomModel.updateData(from: fetchedData.data)
        
        self.navigationController?.pushViewController(privateChatroom, animated: true)
    }
}

extension ItemDetailViewController: StatusChanged {
    func updateStatusButton(status: String) {
        guard let itemId = itemDetailModel.info?.id else {
            return
        }
        updateStatusDelegateIfNeeded()
        switch status {
        case "판매중":
            statusDelegate?.onsale(id: itemId)
        case "예약중":
            statusDelegate?.reservation(id: itemId)
        case "판매완료":
            statusDelegate?.soldOut(id: itemId)
        default:
            break
        }
    }
}

extension ItemDetailViewController: UpdateDelegate {
    func updateScreen() {
        backButtonTouched()
    }
}


