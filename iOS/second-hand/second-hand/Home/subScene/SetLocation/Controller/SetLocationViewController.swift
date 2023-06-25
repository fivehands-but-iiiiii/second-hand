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
    private let firstLocation = UIButton()
    private let secondLocation = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        layout()
    }
    
    private func setUI() {
        setNavigationBar()
        setCommentLabel()
        setFirstLocation()
        setSecondLocation()
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

    private func setFirstLocation() {
        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(systemName: "xmark")
        configuration.imagePlacement = .trailing
        configuration.title = "역삼1동"
        configuration.imagePadding = 50
        firstLocation.configuration = configuration
        
        firstLocation.tintColor = .accentText
        firstLocation.setTitleColor(.accentText, for: .normal)
        firstLocation.titleLabel?.font = .subHead
        firstLocation.backgroundColor = .accentBackgroundPrimary
        firstLocation.layer.cornerRadius = 8
        firstLocation.layer.masksToBounds = true
    }
    
    private func setSecondLocation() {
        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePlacement = .leading
        configuration.title = "label"
        configuration.imagePadding = 4
        configuration.baseBackgroundColor = .white
        secondLocation.configuration = configuration
        
        secondLocation.tintColor = UIColor.accentTextWeak
        secondLocation.setTitleColor(.accentTextWeak, for: .normal)
        secondLocation.titleLabel?.font = UIFont.subHead
        secondLocation.layer.borderColor = CGColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 0.39)
        secondLocation.layer.borderWidth = 1
        secondLocation.layer.cornerRadius = 8
        secondLocation.layer.masksToBounds = true
        
    }
    
    private func layout() {
        [commentLabel, firstLocation, secondLocation].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            commentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 96*heightRatio),
            
            firstLocation.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 48*heightRatio),
            firstLocation.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15*widthRatio),
            firstLocation.widthAnchor.constraint(equalToConstant: 177.5*widthRatio),
            firstLocation.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            secondLocation.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 48*heightRatio),
            secondLocation.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15*widthRatio),
            secondLocation.widthAnchor.constraint(equalToConstant: 177.5*widthRatio),
            secondLocation.heightAnchor.constraint(equalToConstant: 52*heightRatio)
        ])
    }
    
}
