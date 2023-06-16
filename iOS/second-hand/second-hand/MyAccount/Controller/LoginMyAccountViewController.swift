//
//  MyAccountLoginedViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//
protocol isLoginChanged: AnyObject {
    func toggleLogin()
    func loginStatus()
}

import UIKit

final class LoginMyAccountViewController: NavigationUnderLineViewController {
    weak var delegate : isLoginChanged?
    private let circleButton = UIButton()
    private let nicknameLabel = UILabel()
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCircleButton()
        setNicknameLabel()
        setLogoutButton()
        layout()
    }
    
    private func setNicknameLabel() {
        nicknameLabel.frame = CGRect(x: 0, y: 0, width: 363, height: 22)
        nicknameLabel.text = "닉네임"
        nicknameLabel.font = UIFont.headLine
    }
    
    private func setCircleButton() {
        circleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        circleButton.layer.cornerRadius =  circleButton.layer.frame.size.width/2
        circleButton.layer.masksToBounds = true
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        circleButton.setImage(UIImage(systemName: "camera"), for: .normal)
        circleButton.tintColor = .white
        circleButton.backgroundColor = .black
    }
    
    private func setLogoutButton() {
        logoutButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.titleLabel?.font = UIFont.subHead
        logoutButton.backgroundColor = .orange
        logoutButton.layer.cornerRadius = 8
        logoutButton.layer.masksToBounds = true
        logoutButton.addTarget(self, action: #selector(logoutButtonTouched), for: .touchUpInside)
    }
    
    @objc func logoutButtonTouched() {
        delegate?.toggleLogin()
        delegate?.loginStatus()
    }
    
    private func layout() {
        [circleButton, nicknameLabel, logoutButton].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 852
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            circleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 194*heightRatio),
            circleButton.widthAnchor.constraint(equalToConstant: 80),
            circleButton.heightAnchor.constraint(equalToConstant: 80),
            
            nicknameLabel.topAnchor.constraint(equalTo: self.circleButton.bottomAnchor, constant: 24*heightRatio),
            nicknameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -203*heightRatio),
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 361*widthRatio),
            logoutButton.heightAnchor.constraint(equalToConstant: 52*heightRatio)
        ])
    }
}
