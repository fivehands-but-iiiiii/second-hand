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
    private let joinMembershipButton = UIButton()
    private let contour = UILabel()
    private let loginedViewController = LoginedMyAccountViewController()
    private var isLogined = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.addChild(loginedViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLogined {
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
        
        view.addSubview(loginedViewController.view)
        loginedViewController.didMove(toParent: self)
        loginedViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loginedViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                loginedViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loginedViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loginedViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "내 계정"
    }
    
    private func setLoginButton() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.subHead
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = loginButton.layer.frame.height/2
        loginButton.layer.masksToBounds = true
        contour.backgroundColor = .lightGray
        
        loginButton.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
    }
    
    @objc private func loginButtonTouched() { //일단 로그인 성공했다고 가정
        let loginNotification = Notification(name: NSNotification.Name("LOGIN"))
        NotificationCenter.default.post(name: loginNotification.name, object: nil, userInfo: nil)
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
    }
    
    private func setLoginedConstraints() {
        self.view.addSubview(loginButton)
        self.view.addSubview(idStackView)
        self.view.addSubview(joinMembershipButton)
        self.view.addSubview(contour)
        
        idStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        joinMembershipButton.translatesAutoresizingMaskIntoConstraints = false
        contour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 178),
            idStackView.heightAnchor.constraint(equalToConstant: 44),
            idStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            idStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 361),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -204),
            
            joinMembershipButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 19),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            joinMembershipButton.heightAnchor.constraint(equalToConstant: 22),
            
            contour.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 0),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            contour.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
