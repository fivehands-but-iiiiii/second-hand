//
//  AddPhotoScrollView.swift
//  second-hand
//
//  Created by leehwajin on 2023/07/09.
//

import UIKit

final class AddPhotoScrollView: UIScrollView {
    
    var addPhotoStackView = UIStackView()
    let addPhotoButton = UIButton.makeSquare(width: 80, height: 80, radius: 12)
    private let cameraView = UIImageView()
     let countPictureLabel = UILabel()

    private let imageRequest = ImageRequest()
    private let productPicture = ProductImageCount()
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
    
    func addImage(image: UIImage) {
        let newImageView = AddPhotoImageView(image: image) // 새로운 이미지 뷰 생성
        addPhotoStackView.addArrangedSubview(newImageView) // squareimageView가 있는 스택 뷰에 추가
        
        NSLayoutConstraint.activate([
            newImageView.heightAnchor.constraint(equalToConstant: 80),
            newImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
    }
    
    private func setCameraView() {
        //TODO: 여기 URL으로 이미지를 받아서 네트워킹처리해서 이미지를 가져와야함. 지금은 system이미지 불러오는걸로..
        cameraView.image = UIImage(systemName: imageRequest.image)
        cameraView.tintColor = .black
        
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cameraView)
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
            buttonComponentStackView.centerYAnchor.constraint(equalTo: addPhotoButton.centerYAnchor)
        ])
    }
    
    
}
