//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class NotLoginMyAccountViewController: NavigationUnderLineViewController {
    private let idStackView = IdStackView()
    private let loginButton = UIButton()
    private let githubLoginButton = UIButton()
    private let joinMembershipButton = UIButton()
    private let contour = UILabel()
    private let loginViewController = LoginMyAccountViewController()
    private var isLogin = false
    
    var joinViewController = JoinViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.addChild(loginViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLogin {
            setLoginedUI()
        }
        else {
            setNotLoginedUI()
        }
    }

    private func setObserver() {
    }
    
    private func setLoginedUI() {
        for subview in view.subviews {
                subview.removeFromSuperview()
            }
        
        view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        loginViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loginViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                loginViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loginViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loginViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
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
        
        
        contour.backgroundColor = .lightGray
        joinMembershipButton.addTarget(self, action: #selector(joinButtonTouched), for: .touchUpInside)
        
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

        }
    
    @objc private func loginButtonTouched() { //일단 로그인 성공했다고 가정
        let loginNotification = Notification(name: NSNotification.Name("LOGIN"))
        NotificationCenter.default.post(name: loginNotification.name, object: nil, userInfo: nil)
        // TODO: 싱글톤으로 전역처럼 사용할 변수만들어야 할 듯
    }
    
    @objc private func githubLoginButtonTouched() {
        present(GIthubWebViewController(), animated: true)
    }
    
    
    private func setJoinButton() {
        joinMembershipButton.setTitle("회원가입", for: .normal)
        joinMembershipButton.titleLabel?.font = UIFont.subHead
        joinMembershipButton.setTitleColor(.black, for: .normal)
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
    }
    
    private func setLoginedConstraints() {
        self.view.addSubview(loginButton)
        self.view.addSubview(idStackView)
        self.view.addSubview(joinMembershipButton)
        self.view.addSubview(contour)
        self.view.addSubview(githubLoginButton)
        
        idStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        joinMembershipButton.translatesAutoresizingMaskIntoConstraints = false
        contour.translatesAutoresizingMaskIntoConstraints = false
        githubLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            idStackView.heightAnchor.constraint(equalToConstant: 44),
            idStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            idStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 361),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: joinMembershipButton.topAnchor, constant: -19),
            
            joinMembershipButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -163),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            joinMembershipButton.heightAnchor.constraint(equalToConstant: 22),
            
            contour.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 0),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            contour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            githubLoginButton.widthAnchor.constraint(equalToConstant: 361),
            githubLoginButton.heightAnchor.constraint(equalToConstant: 52),
            githubLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            githubLoginButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -19),
        ])
    }
}
