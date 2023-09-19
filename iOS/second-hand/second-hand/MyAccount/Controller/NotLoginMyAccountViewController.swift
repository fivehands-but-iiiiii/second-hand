//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

final class NotLoginMyAccountViewController: NavigationUnderLineViewController {
    private let joinViewController = JoinViewController()
    private let loginViewController = LoginMyAccountViewController()
    private let githubWebViewController = GithubWebViewController()
    private let loginButton = UIButton()
    private let githubLoginButton = UIButton()
    private let joinMembershipButton = UIButton()
    private let idInputSection = IdInputSection(frame: .zero)
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotLogOnUI()
        self.addChild(loginViewController)
        setObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //isLogin은 추후 싱글톤으로 대체될 예정
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLogin), name: NSNotification.Name("LOGIN"), object: nil)
    }
    
    @objc private func didRecieveLogin() {
        setLogOnUI()
    }
    
    private func setLogOnUI() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        self.view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            loginViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setNotLogOnUI() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        setNavigationBar()
        setLoginButton()
        setJoinButton()
        setLoginedConstraints()
        setGithubLoginButton()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "내 계정"
    }
    
    private func setLoginButton() {
        loginButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.subHead
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = 8
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
    }
    
    private func setGithubLoginButton() {
        githubLoginButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        githubLoginButton.setTitle("GitHub 계정으로 로그인", for: .normal)
        githubLoginButton.titleLabel?.font = UIFont.subHead
        githubLoginButton.backgroundColor = .black
        githubLoginButton.layer.cornerRadius = 8
        githubLoginButton.layer.masksToBounds = true
        githubLoginButton.addTarget(self, action: #selector(githubLoginButtonTouched), for: .touchUpInside)
    }
    
    @objc func joinButtonTouched() {
        present(UINavigationController(rootViewController: joinViewController), animated: true)
    }
    
    @objc private func loginButtonTouched() { //일단 로그인 성공했다고 가정

        loginTest()

    }
    
    @objc private func githubLoginButtonTouched() {
        self.navigationController?.pushViewController(githubWebViewController, animated: true)
    }
    
    
    private func setJoinButton() {
        joinMembershipButton.setTitle("회원가입", for: .normal)
        joinMembershipButton.titleLabel?.font = UIFont.subHead
        joinMembershipButton.setTitleColor(.black, for: .normal)
        joinMembershipButton.addTarget(self, action: #selector(joinButtonTouched), for: .touchUpInside)
    }

    
    private func setLoginedConstraints() {
        [loginButton, joinMembershipButton, githubLoginButton, idInputSection].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 748
        let figmaWidth: CGFloat = 393
        let heightRatio = height/figmaHeight
        let widthRatio = width/figmaWidth
        
        
        NSLayoutConstraint.activate([
            
            joinMembershipButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120*heightRatio),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            githubLoginButton.bottomAnchor.constraint(equalTo: self.joinMembershipButton.topAnchor, constant: -19*heightRatio),
            githubLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            githubLoginButton.widthAnchor.constraint(equalToConstant: 361*widthRatio),
            githubLoginButton.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            loginButton.bottomAnchor.constraint(equalTo: self.githubLoginButton.topAnchor, constant: -19*heightRatio),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 361*widthRatio),
            loginButton.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            idInputSection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            idInputSection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            idInputSection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 88.0),
            idInputSection.heightAnchor.constraint(equalToConstant: 88.0),
        ])
    }

    //MARK: 일반 로그인 테스트
    private func loginTest() {
  
        let networkManager = NetworkManager()
        
        guard let id = idInputSection.idTextField.text else {return}

        let jsonString = """
                            {"memberId": "\(id)"}
                        """
        guard let loginURL = URL(string:Server.shared.url(for: .login)) else {
            return
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        
        do {
            networkManager.sendPOST(decodeType: LoginSuccess.self, what: jsonData, header: nil, fromURL: loginURL) { (result: Result<LoginSuccess, Error>) in
                switch result {
                case .success(let user) :
                    UserInfoManager.shared.updateData(from: user.data)
                    
                    print("로그인성공  \(user)")
                  
                    self.setLogOnUI()
                    self.subscribeSSE()
                    
                case .failure(let error) :
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "로그인 실패", message: "아이디를 확인해주세요.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    //MARK: About subscribe SSE
    private func subscribeSSE() {
        let header = makeSSEHeader()
        let body = makeSSEBody()
        guard let url = URL(string: makeSSEURL()) else {
            return
        }
        
        NetworkManager.sendGET(decodeType: SubscribeSSESuccess.self, header: header, body: nil, fromURL: url ) { (result: Result<[SubscribeSSESuccess], Error>) in
            switch result {
            case .success(let response) :
                let data = response.last
                print(data)
                //Request timeout Error
            case .failure(let error) :
                print("SSE 구독 실패 \(error)")
            }
        }
    }
    
    private func makeSSEHeader()-> [String:String]? {
        let authorizationKey: String = JSONCreater.headerKeyAuthorization
        
        guard let authorizationValue: String = UserInfoManager.shared.loginToken else {
            return nil
        }
        
        let contentTypeKey: String = JSONCreater.headerKeyContentType
        
        
        guard let userInfo = UserInfoManager.shared.userInfo else {
            return [authorizationKey:authorizationValue,contentTypeKey:"text/event-stream","Cache-Control": "no-store"]
        }
        
        let header = [authorizationKey:authorizationValue,contentTypeKey:"text/event-stream","Cache-Control": "no-store"]
        //LastEventID 아직 안넣었음. timeout Error 해결하고 넣을 예정
        return header
    }
    
    private func makeSSEBody() -> Data? {
        let body = JSONCreater().createSSESubscribeBody()
        
        return body
    }
    
    private func makeSSEURL() -> String {
        let url = Server.shared.createSSESubscribeURL()
        
        return url
    }
}
