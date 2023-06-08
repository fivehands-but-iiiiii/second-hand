//
//  MyAccountViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/05.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    let idStackView = IdStackView()
    let loginButton = UIButton()
    let joinMembershipButton = UIButton()
    let contour = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layout()
        setting()
        setNavigationBarBottomBorder()
    }
    
    func setting() {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "내 계정"
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.subHead
        loginButton.backgroundColor = .orange
        self.view.layoutIfNeeded()
        loginButton.layer.cornerRadius = loginButton.layer.frame.height/2
        loginButton.layer.masksToBounds = true
        
        joinMembershipButton.setTitle("회원가입", for: .normal)
        joinMembershipButton.titleLabel?.font = UIFont.subHead
        joinMembershipButton.setTitleColor(.black, for: .normal)
        
        contour.backgroundColor = .lightGray
    }
    
    func layout() {
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
            
            loginButton.widthAnchor.constraint(equalToConstant: 361),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -204),
            
            joinMembershipButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 19),
            joinMembershipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            joinMembershipButton.heightAnchor.constraint(equalToConstant: 22),
            
            contour.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 0),
            contour.heightAnchor.constraint(equalToConstant: 0.5),
            contour.widthAnchor.constraint(equalToConstant: self.view.frame.width)
        ])
    }
    
    func setNavigationBarBottomBorder() {
            let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 0 - 1, width: navigationController?.navigationBar.frame.width ?? 0, height: 1))
            borderView.backgroundColor = .lightGray
            navigationController?.navigationBar.addSubview(borderView)
        }
    
}
