//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class MyAccountViewController: NavigationUnderLineViewController {
    var joinViewController = JoinViewController()
    
    let idLabel = UILabel()
    let idTextField = UITextField()
    let loginButton = UIButton()
    let joinMembershipButton = UIButton()
    let contour = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
    }
    
    func setUI() {
        self.navigationItem.title = "내 계정"
        setLoginButton()
        setJoinMembershipButton()
        setIdLabel()
        setIdTextField()
        setContour()
    }
    
    func setLoginButton() {
        loginButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.subHead
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = 8
        loginButton.layer.masksToBounds = true
    }
    
    
    func setJoinMembershipButton() {
        joinMembershipButton.setTitle("회원가입", for: .normal)
        joinMembershipButton.titleLabel?.font = UIFont.subHead
        joinMembershipButton.setTitleColor(.black, for: .normal)
        joinMembershipButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    @objc func joinButtonTapped() {
        present(UINavigationController(rootViewController: joinViewController), animated: true)
    }
    
    func setIdLabel() {
        idLabel.text = "아이디"
        idLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        
    }
    
    func setIdTextField() {
        idTextField.placeholder = "아이디를 입력하세요"
    }
    
    func setContour() {
        contour.backgroundColor = UIColor.neutralBorder
    }
    
    func layout() {
        self.view.addSubview(loginButton)
        self.view.addSubview(joinMembershipButton)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(contour)
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        joinMembershipButton.translatesAutoresizingMaskIntoConstraints = false
        contour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 189),
            idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 52.74),
            idTextField.topAnchor.constraint(equalTo: idLabel.topAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 361),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -204),
            
            joinMembershipButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 19),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            joinMembershipButton.heightAnchor.constraint(equalToConstant: 22),
            
            contour.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10.5),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width)
        ])
    }
}
