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
    
    static let buttonHeightWidth: CGFloat = 80
    
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
        nicknameLabel.text = UserInfoManager.shared.userInfo?.memberId
        nicknameLabel.font = UIFont.headLine
    }
    
    private func setCircleButton() {
        
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        circleButton.setImage(UIImage(systemName: "camera"), for: .normal)
        circleButton.tintColor = .white
        
        guard let user = UserInfoManager.shared.userInfo else {
            return
        }
        
        circleButton.setImage(from: user.profileImgUrl)
        
        circleButton.layer.cornerRadius =  Self.buttonHeightWidth / 2
        circleButton.layer.masksToBounds = true
    }
    
    private func setLogoutButton() {
        
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
        
        if let selectedNavVC = self.tabBarController?.selectedViewController as? UINavigationController {
            selectedNavVC.setViewControllers([NotLoginMyAccountViewController()], animated: true)
        }
        
        NetworkManager.logout()
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
