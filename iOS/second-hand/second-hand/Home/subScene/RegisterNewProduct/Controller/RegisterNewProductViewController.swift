//
//  RegisterNewProductViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/21.
//

import UIKit

final class RegisterNewProductViewController: NavigationUnderLineViewController {
    
    private let productPicture = ProductPicture()
    private let imageRequest = ImageRequest()
    private let sectionLine1 = UIView.makeLine()
    private let sectionLine2 = UIView.makeLine()
    private let sectionLine3 = UIView.makeLine()
    private let square = UIButton.makeSquare(width: 80, height: 80, radius: 12)
    private let cameraView = UIImageView()
    private let countPictureLabel = UILabel()
    private let imageLabelStackView = UIStackView()
    private let imageStackView = UIStackView()
    private let titleTextField = UITextField()
    private let priceTextField = UITextField()
    private let descriptionTextField = UITextView()
    private let textViewPlaceHolder = ""
    //let textViewPlaceHolder = "\(location)"
    //TODO: 장소가 결정된다면 하드코딩 지우고 받아와야함
    private let location = "역삼1동"
    private let wonIcon = UILabel()
    
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
        setToolbar()
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
        countPictureLabel.text = "\(productPicture.count)/10"
        countPictureLabel.font = .systemFont(ofSize: 13)
        countPictureLabel.textColor = .neutralTextStrong
        countPictureLabel.textAlignment = .center
    }
    
    private func setStackView() {
        imageLabelStackView.addArrangedSubview(cameraView)
        imageLabelStackView.addArrangedSubview(countPictureLabel)
        imageLabelStackView.spacing = 5
        imageLabelStackView.axis = .vertical
    }
    
    private func setTextField() {
        titleTextField.placeholder = "글제목"
        priceTextField.placeholder = "가격(선택사항)"
        priceTextField.delegate = self
        descriptionTextField.delegate = self // txtvReview가 유저가 선언한 outlet
        descriptionTextField.text = "\(location)에 올릴 게시물 내용을 작성해주세요. (판매금지 물품은 게시가 제한될 수 있어요.)"
        descriptionTextField.textColor = .neutralTextWeak
        descriptionTextField.font = .systemFont(ofSize: 15)
        wonIcon.text = "₩"
        wonIcon.font = .systemFont(ofSize: 15)
        wonIcon.textColor = .neutralTextWeak
        
        [titleTextField, priceTextField].forEach{
            $0.font = .systemFont(ofSize: 15)
            $0.setPlaceholder(color: .neutralTextWeak)
        }
        
    }
    
    private func setToolbar() {
        navigationController?.isToolbarHidden = false
        let appearance = UIToolbarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .neutralBackgroundWeak
            navigationController?.toolbar.scrollEdgeAppearance = appearance
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
            titleTextField.bottomAnchor.constraint(equalTo: sectionLine2.topAnchor, constant: -15),
            
            wonIcon.leadingAnchor.constraint(equalTo: square.leadingAnchor),
            wonIcon.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 15),
            wonIcon.bottomAnchor.constraint(equalTo: sectionLine3.topAnchor, constant: -15),
            
            priceTextField.leadingAnchor.constraint(equalTo: wonIcon.trailingAnchor, constant: 3),
            priceTextField.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 15),
            priceTextField.bottomAnchor.constraint(equalTo: sectionLine3.topAnchor, constant: -15),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: square.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            descriptionTextField.topAnchor.constraint(equalTo: sectionLine3.bottomAnchor, constant: 15),
            descriptionTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    private func registerPhotoButtonTapped() {
        
    }
}

extension RegisterNewProductViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .neutralTextWeak {
            textView.text = nil
            textView.textColor = UIColor.neutralText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "\(location)에 올릴 게시물 내용을 작성해주세요. (판매금지 물품은 게시가 제한될 수 있어요.)"
            textView.textColor = .neutralTextWeak
        }
    }
}

extension RegisterNewProductViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.isEmpty || isNumber(string)
    }
    
    private func isNumber(_ string: String) -> Bool {
        let number = CharacterSet(charactersIn: "1234567890")
        guard let scalar = UnicodeScalar(string) else {
            return false
        }
        return number.contains(scalar)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //화면 터치시 키보드 내려감
        priceTextField.resignFirstResponder()
    }
    
}


