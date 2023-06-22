//
//  RegisterNewProductViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/21.
//

import UIKit

final class RegisterNewProductViewController: NavigationUnderLineViewController {
    
    var productPicture = ProductPicture()
    var imageRequest = ImageRequest()
    let sectionLine1 = UIView.makeLine()
    let sectionLine2 = UIView.makeLine()
    let sectionLine3 = UIView.makeLine()
    let square = UIButton.makeSquare(width: 80, height: 80, radius: 12)
    let cameraView = UIImageView()
    let countPictureLabel = UILabel()
    let imageLabelStackView = UIStackView()
    let imageStackView = UIStackView()
    let titleTextField = UITextField()
    let priceTextField = UITextField()
    let descriptionTextField = UITextField()
    //TODO: 장소가 결정된다면 하드코딩 지우고 받아와야함
    let location = "역삼1동"
    let wonIcon = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        layout()
    }
    
    private func setUI() {
        setNavigation()
        setCameraView()
        setCountPictureLabel()
        setStackView()
        setTextField()
    }
    
    private func setNavigation() {
        navigationItem.title = "내 물건 팔기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .neutralText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .neutralTextWeak
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func finishButtonTapped() {
        print("저장")
    }
    
    func setCameraView() {
        //TODO: 여기 URL으로 이미지를 받아서 네트워킹처리해서 이미지를 가져와야함. 지금은 system이미지 불러오는걸로..
        cameraView.image = UIImage(systemName: imageRequest.image)
        cameraView.tintColor = .black
        NSLayoutConstraint.activate([
            cameraView.heightAnchor.constraint(equalToConstant: 29),
            cameraView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func setCountPictureLabel() {
        countPictureLabel.text = "\(productPicture.count)/10"
        countPictureLabel.font = .systemFont(ofSize: 13)
        countPictureLabel.textColor = .neutralTextStrong
        countPictureLabel.textAlignment = .center
    }
    
    func setStackView() {
        imageLabelStackView.addArrangedSubview(cameraView)
        imageLabelStackView.addArrangedSubview(countPictureLabel)
        imageLabelStackView.spacing = 5
        imageLabelStackView.axis = .vertical
    }
    
    func setTextField() {
        titleTextField.placeholder = "글제목"
        priceTextField.placeholder = "가격(선택사항)"
        descriptionTextField.placeholder = "\(location)에 올릴 게시물 내용을 작성해주세요.(판매금지 물품은 게시가 제한될 수 있어요.)"
        wonIcon.text = "₩"
        wonIcon.font = .systemFont(ofSize: 15)
        wonIcon.textColor = .neutralTextWeak
        
        [titleTextField, priceTextField, descriptionTextField].forEach{
            $0.font = .systemFont(ofSize: 15)
            $0.setPlaceholder(color: .neutralTextWeak)
        }
        
    }
    
    private func layout() {
        let sectionArr = [sectionLine1, sectionLine2, sectionLine3, square, imageLabelStackView, titleTextField, priceTextField, descriptionTextField, wonIcon]
        sectionArr.forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            
            sectionLine1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 167),
            sectionLine1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
            sectionLine2.topAnchor.constraint(equalTo: sectionLine1.bottomAnchor, constant: 52),
            sectionLine2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            sectionLine3.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 52),
            sectionLine3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            square.bottomAnchor.constraint(equalTo: sectionLine1.topAnchor, constant: -15),
            square.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            imageLabelStackView.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            imageLabelStackView.centerYAnchor.constraint(equalTo: square.centerYAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: square.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: sectionLine1.bottomAnchor, constant: 15),
            titleTextField.bottomAnchor.constraint(equalTo: sectionLine2.topAnchor, constant: -15)
            
        ])
    }
}

