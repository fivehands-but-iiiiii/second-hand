//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

final class NotLoginMyAccountViewController: NavigationUnderLineViewController, isLoginChanged {
    private let joinViewController = JoinViewController()
    private let loginViewController = LoginMyAccountViewController()
    private let githubWebViewController = GithubWebViewController()
    private let loginButton = UIButton()
    private let githubLoginButton = UIButton()
    private let joinMembershipButton = UIButton()
    private let contour = UILabel()
    private let idStackView = IdStackView()
    //isLogin은 추후 싱글톤으로 대체될 예정
    private var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.addChild(loginViewController)
        loginViewController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //isLogin은 추후 싱글톤으로 대체될 예정
        loginStatus()
        
    }
    
    func toggleLogin() {
        if isLogin == true {
            isLogin = false
        }else {
            isLogin = true
        }
    }
    
    func loginStatus() {
        if isLogin {
            setLoginedUI()
        }
        else {
            setNotLoginedUI()
        }
    }
    
    private func setLoginedUI() {
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
    
    private func setNotLoginedUI() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        setNavigationBar()
        setLoginButton()
        setJoinButton()
        setLoginedConstraints()
        setGithubLoginButton()
        contour.backgroundColor = UIColor.neutralBorder
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
        let loginNotification = Notification(name: NSNotification.Name("LOGIN"))
        NotificationCenter.default.post(name: loginNotification.name, object: nil, userInfo: nil)
        // TODO: 싱글톤으로 전역처럼 사용할 변수만들어야하는데, 네트워킹 진행하면서 구현할 예정
        isLogin = true
        
        setLoginedUI()
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
        [loginButton, idStackView, joinMembershipButton, contour, githubLoginButton].forEach{
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
            idStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 189*heightRatio),
            idStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            contour.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 10.5*widthRatio),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            contour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            joinMembershipButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120*heightRatio),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            

            githubLoginButton.bottomAnchor.constraint(equalTo: self.joinMembershipButton.topAnchor, constant: -19*heightRatio),
            githubLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            githubLoginButton.widthAnchor.constraint(equalToConstant: 361*widthRatio),
            githubLoginButton.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            loginButton.bottomAnchor.constraint(equalTo: self.githubLoginButton.topAnchor, constant: -19*heightRatio),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 361*widthRatio),
            loginButton.heightAnchor.constraint(equalToConstant: 52*heightRatio)
        ])
    }
}
