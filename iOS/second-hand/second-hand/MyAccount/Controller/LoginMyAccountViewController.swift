//
//  MyAccountLoginedViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/12.
//

import UIKit

final class LoginMyAccountViewController: NavigationUnderLineViewController {
    private let circleButton = UIButton()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCircleButton()
        setLabel()
        layout()
    }
    
    private func setLabel() {
        label.frame = CGRect(x: 300, y: 300, width: 50, height: 50)
        label.text = "로그인이 된 내계정 화면임 !!"
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
    
    private func layout() {
        self.view.addSubview(circleButton)
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        ])
    }
}
