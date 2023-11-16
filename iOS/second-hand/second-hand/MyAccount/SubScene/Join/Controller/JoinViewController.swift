//
//  JoinViewController.swift
//  second-hand
//
//  Created by SONG on 2023/06/14.
//

import UIKit

final class JoinViewController: NavigationUnderLineViewController {
    private let setLocationViewController = SetLocationViewController()
    private let circleButton = UIButton()
    private let idInputSection = IdInputSection(frame: .zero)
    private let addLocationButton = UIButton()
    private let stackView = UIStackView()
    private let plusLabel = UILabel()
    private let addLocationText = UILabel()
    private let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        joinTest()
    }
    
    private func setUI() {
        setNavigationBar()
        setCircleButton()
        setConstraints()
        setAddLocationButton()
        setStackView()
    }
    
    private func setCircleButton() {
        circleButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // 크기 설정
        circleButton.layer.cornerRadius = circleButton.layer.frame.size.width/2
        circleButton.layer.masksToBounds = true
        circleButton.layer.borderWidth = 1
        circleButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        circleButton.setImage(UIImage(systemName: "camera"), for: .normal)
        circleButton.tintColor = .black
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "회원가입"
        setNavigationRightBarButton()
        setNavigationLeftBarButton()
    }
    
    private func setNavigationRightBarButton() {
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(save))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralTextWeak]
        saveButton.setTitleTextAttributes(leftBarAttribute, for: .normal)
        navigationItem.rightBarButtonItem = saveButton
        alert.addAction(UIAlertAction(title: "확인", style: .default))
    }
    
    @objc private func save() {
        if idInputSection.idDescription.text == "" {
            alert.message = "회원가입이 완료되었습니다."
            self.present(alert, animated: true, completion: nil)
        }else {
            alert.message = "아이디가 적절하지 않습니다."
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setNavigationLeftBarButton() {
        let backButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(viewControllerDismiss))
        
        let leftBarAttribute = [NSAttributedString.Key.font: UIFont.body,
                                NSAttributedString.Key.foregroundColor: UIColor.neutralText]
        backButton.setTitleTextAttributes(leftBarAttribute, for: .normal)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func viewControllerDismiss() {
        self.dismiss(animated: true)
    }
    
    private func setAddLocationButton() {
        addLocationButton.frame = CGRect(x: 0, y: 0, width: 361, height: 52)
        addLocationButton.layer.borderWidth = 1
        addLocationButton.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.layer.cornerRadius = 8
        addLocationButton.layer.masksToBounds = true
        addLocationButton.addTarget(self, action: #selector(toSetLocation), for: .touchUpInside)
    }
    
    @objc private func toSetLocation() {
        present(UINavigationController(rootViewController: setLocationViewController), animated: true)
    }
    
    private func setAddLocationText() {
        addLocationText.text = "위치 추가"
        addLocationText.font = UIFont.subHead
        self.stackView.addArrangedSubview(addLocationText)
    }
    
    private func setPlusLabel() {
        //일단 임의로 작성
        plusLabel.text = "+"
        plusLabel.font = UIFont.subHead
        plusLabel.textAlignment = .center
        self.stackView.addArrangedSubview(plusLabel)
    }
    
    private func setStackView() {
        setPlusLabel()
        setAddLocationText()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private func setConstraints() {
        let addSubviewComponent = [circleButton, addLocationButton,idInputSection]
        addSubviewComponent.forEach{self.view.addSubview($0)}
        self.addLocationButton.addSubview(stackView)
        
        let component = [circleButton, addLocationButton, plusLabel, addLocationText, stackView, idInputSection]
        component.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        let figmaHeight: CGFloat = 794
        let figmaWidth: CGFloat = 393
        let heightRatio: CGFloat = height/figmaHeight
        let widthRatio: CGFloat = width/figmaWidth
        
        NSLayoutConstraint.activate([
            circleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 136*heightRatio),
            circleButton.widthAnchor.constraint(equalToConstant: 80),
            circleButton.heightAnchor.constraint(equalToConstant: 80),
            
            idInputSection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            idInputSection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            idInputSection.topAnchor.constraint(equalTo: circleButton.bottomAnchor, constant:30),
            idInputSection.heightAnchor.constraint(equalToConstant: 88.0),
            
            addLocationButton.topAnchor.constraint(equalTo: idInputSection.bottomAnchor, constant: 10*heightRatio),
            addLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16*widthRatio),
            addLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16*widthRatio),
            addLocationButton.heightAnchor.constraint(equalToConstant: 52*heightRatio),
            
            stackView.centerXAnchor.constraint(equalTo: self.addLocationButton.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.addLocationButton.centerYAnchor)
            
        ])
    }
    //MARK: 일반회원가입 테스트
    //TODO: 테스트 완료후 하드코딩 제거 
    func joinTest() {
        let networkManager = NetworkManager()
        
        let jsonString = """
                        {"memberId": "gandalf","profileImgUrl":"https://i.namu.wiki/i/Jn2dtgfZ9U5q2tiuzbm61OWamtZG3gto17M8L3mJiKnLPFAEJteImAQuIVPv-TiFROjhNa50okMMFhtJJ3mc5yNotLQsLU910vNhtYbRJt05mH-LudmopQPfOVXEJDoWQrEV5vY5PbNAO_3XAg8_HQ.webp","regions": [{"id": 1,"onFocus": true}]}
                        """
        guard let joinURL = URL(string:EndpointHandler.shared.url(for: .join)) else {
            return
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        
        do {
            networkManager.sendPOST(decodeType: JoinSuccess.self, what: jsonData, header: nil, fromURL: joinURL) { (result: Result<JoinSuccess, Error>) in
                switch result {
                case .success(let user) :
                    print("가입성공  \(user)")
                case .failure(let error) :
                    print("가입실패 \(error)")
                }
            }
        } catch {
            print("Error decoding response header: \(error)")
        }
    }
}
