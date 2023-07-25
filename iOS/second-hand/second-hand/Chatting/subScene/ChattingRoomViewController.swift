//
//  ChattingRoomViewController.swift
//  second-hand
//
//  Created by SONG on 2023/07/19.
//

import UIKit

class ChattingRoomViewController: UIViewController {
    private var backButton: UIButton? = nil
    private var menuButton: UIButton? = nil
    private var chatroomTitle: UILabel? = nil
    var privateChatroomModel = PrivateChatroomModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    private func commonInit() {
        self.view.backgroundColor = .systemBackground
        generateBackButton()
        generateMenuButton()
        setConstraintsBackButton()
        setConstraintsMenuButton()
        didUpdateModel()
    }
    
    private func didUpdateModel() {
        setChatroomTitle()
    }
    
    // MARK: NavigationBar (Buttons , title)
    private func setChatroomTitle() {
        self.chatroomTitle = UILabel(frame: .zero)
        self.chatroomTitle?.text = privateChatroomModel.info?.opponentId

        self.chatroomTitle?.font = .systemFont(ofSize: 17.0)
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
}
