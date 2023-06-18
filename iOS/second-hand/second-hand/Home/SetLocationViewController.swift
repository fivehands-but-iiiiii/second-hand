//
//  SetLocation.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/18.
//

import Foundation
//
//  setLocationViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/18.
//

import UIKit

final class SetLocationViewController: NavigationUnderLineViewController {

    private let commentLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        layout()
    }
    
    private func setUI() {
        setNavigationBar()
        setCommentLabel()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "동네 설정"
        let cancelButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .neutralText
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setCommentLabel() {
        commentLabel.text = "지역은 최소 1개,\n 최대 2개까지 설정 가능해요."
        commentLabel.font = UIFont.footNote
        commentLabel.textColor = .neutralTextStrong
        commentLabel.numberOfLines = 2
        commentLabel.textAlignment = .center
    }
    
    private func layout() {
        self.view.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            commentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 96*heightRatio),
        ])
    }
    
}
