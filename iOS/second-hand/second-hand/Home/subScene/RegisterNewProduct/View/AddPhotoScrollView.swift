//
//  AddPhotoScrollView.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/09.
//

import UIKit

final class AddPhotoScrollView: UIScrollView {
    
    private var addPhotoStackView = UIStackView()
    private let addPhotoButton = UIButton.makeSquare(width: 80, height: 80, radius: 12)
    private let cameraView = UIImageView()
    private let countPictureLabel = UILabel()
    private let squareimageView = AddPhotoImageView()
    private let imageRequest = ImageRequest()
    private let productPicture = ProductPictureCount()
    private let buttonComponentStackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPhotoStackView.spacing = 16
        setUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addPhotoStackView.spacing = 16
        setUI()
        layout()
    }
    
    private func layout() {
        addPhotoStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addPhotoStackView)
        NSLayoutConstraint.activate([
            addPhotoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            addPhotoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addPhotoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addPhotoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        //스크롤바 가리기
        self.showsHorizontalScrollIndicator = false
    }
    
    private func setUI() {
        setCameraView()
        setCountPictureLabel()
        setAddPhotoButton()
        setButtonComponentStackView()
        addPhotoStackView.addArrangedSubview(addPhotoButton) // 추가됨
    }
    private func setCameraView() {
        //TODO: 여기 URL으로 이미지를 받아서 네트워킹처리해서 이미지를 가져와야함. 지금은 system이미지 불러오는걸로..
        cameraView.image = UIImage(systemName: imageRequest.image)
        cameraView.tintColor = .black
        NSLayoutConstraint.activate([
            cameraView.heightAnchor.constraint(equalToConstant: 29),
            cameraView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setCountPictureLabel() {
        countPictureLabel.text = "\(productPicture.number)/10"
        countPictureLabel.font = .systemFont(ofSize: 13)
        countPictureLabel.textColor = .neutralTextStrong
        countPictureLabel.textAlignment = .center
    }
    
    private func setButtonComponentStackView() {
        buttonComponentStackView.addArrangedSubview(cameraView)
        buttonComponentStackView.addArrangedSubview(countPictureLabel)
        buttonComponentStackView.spacing = 5
        buttonComponentStackView.axis = .vertical
    }
    
    private func setAddPhotoButton() {
        buttonComponentStackView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.addSubview(buttonComponentStackView)
            
            NSLayoutConstraint.activate([
                buttonComponentStackView.centerXAnchor.constraint(equalTo: addPhotoButton.centerXAnchor),
                buttonComponentStackView.centerYAnchor.constraint(equalTo: addPhotoButton.centerYAnchor),
                buttonComponentStackView.widthAnchor.constraint(equalToConstant: 80),
                buttonComponentStackView.heightAnchor.constraint(equalToConstant: 80)
            ])
    }

}
