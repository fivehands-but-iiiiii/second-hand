//
//  RegisterNewProductViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/21.
//

import UIKit
import PhotosUI

final class RegisterNewProductViewController: NavigationUnderLineViewController {
    
    private let sectionLine1 = UIView.makeLine()
    private let sectionLine2 = UIView.makeLine()
    private let sectionLine3 = UIView.makeLine()
    private let photoScrollView = AddPhotoScrollView()
    private let titleTextField = UITextField()
    private let priceTextField = UITextField()
    private let descriptionTextField = UITextView()
    private let textViewPlaceHolder = ""
    //let textViewPlaceHolder = "\(location)"
    //TODO: 장소가 결정된다면 하드코딩 지우고 받아와야함
    private let location = "역삼1동"
    private let wonIcon = UILabel()
    private var photoArray = [PHPickerResult]()
    var countImage = ProductImageCount()
    private let maximumPhotoNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        layout()
        setPHPPicker()
        
    }
    
    private func setUI() {
        setNavigation()
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
    
    @objc func finishButtonTapped() {
        let group = DispatchGroup()
        var imagesData: [Data] = []
        
        for result in photoArray {
            group.enter()
            getImageData(from: result) { imageData in
                if let imageData = imageData {
                    imagesData.append(imageData)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [self] in
            let title = titleTextField.text
            let contents = descriptionTextField.text
            let category: Int64 = 1
            let region: Int64 = 1
            let price: Int32 = Int32(Int(priceTextField.text!)!)
            
            // Multipart form data 생성
            let boundary = "Boundary-\(UUID().uuidString)"
            
            var body = Data()
            
            let parameters: [String: Any] = ["title": title ?? "",
                                             "contents": contents ?? "",
                                             "category": category,
                                             "region": region,
                                             "price": price]
            
            for (key, value) in parameters {
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(value)\r\n".utf8))
            }
            
            let imgDataKey = "img"
            let boundaryPrefix = "--\(boundary)\r\n"
            let boundarySuffix = "--\(boundary)--\r\n"
            
            for (index, imageData) in imagesData.enumerated() {
                let imageName = "image\(index)"
                body.append(Data(boundaryPrefix.utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(imageName).jpg\"\r\n".utf8))
                body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
                body.append(imageData)
                body.append(Data("\r\n".utf8))
            }
            
            body.append(Data(boundarySuffix.utf8))
        }
    }
    
    func getImageData(from result: PHPickerResult, completion: @escaping (Data?) -> Void) {
        let itemProvider = result.itemProvider
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                if let image = image as? UIImage, let data = image.jpegData(compressionQuality: 0.8) {
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setTextField() {
        titleTextField.placeholder = "글제목"
        priceTextField.placeholder = "가격(선택사항)"
        priceTextField.delegate = self
        descriptionTextField.delegate = self
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
        let sectionArr = [sectionLine1, sectionLine2, sectionLine3, titleTextField, priceTextField, descriptionTextField, wonIcon, photoScrollView]
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
            
            photoScrollView.bottomAnchor.constraint(equalTo: sectionLine1.topAnchor, constant: -15),
            photoScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            photoScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            photoScrollView.heightAnchor.constraint(equalToConstant: 80),
            titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            titleTextField.topAnchor.constraint(equalTo: sectionLine1.bottomAnchor, constant: 15),
            titleTextField.bottomAnchor.constraint(equalTo: sectionLine2.topAnchor, constant: -15),
            
            wonIcon.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            wonIcon.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 15),
            wonIcon.bottomAnchor.constraint(equalTo: sectionLine3.topAnchor, constant: -15),
            
            priceTextField.leadingAnchor.constraint(equalTo: wonIcon.trailingAnchor, constant: 3),
            priceTextField.topAnchor.constraint(equalTo: sectionLine2.bottomAnchor, constant: 15),
            priceTextField.bottomAnchor.constraint(equalTo: sectionLine3.topAnchor, constant: -15),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            descriptionTextField.topAnchor.constraint(equalTo: sectionLine3.bottomAnchor, constant: 15),
            descriptionTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}


//갤러리와 관련된 코드들 집합
extension RegisterNewProductViewController: PHPickerViewControllerDelegate  {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        for result in results {
            let itemProvider = result.itemProvider
            if let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
               let utType = UTType(typeIdentifier),
               utType.conforms(to: .image) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async { [self] in
                            
                            //TODO: 특정한 사진이 안올라가는 버그 고치기
                            photoScrollView.addImage(image: image)
                            countImage.addImage()
                            self.photoScrollView.countPictureLabel.text = "\(countImage.number)/\(maximumPhotoNumber)"
                        }
                    }
                }
            }
        }
        photoArray.append(contentsOf: results)
        print("포토어레이 \(photoArray)")
        print(photoArray.count)
    }
    
    private func setPHPPicker() {
        photoScrollView.addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func addPhotoButtonTapped() {
        //TODO: 버튼배경(?)을눌렀으시만(카메라뷰나 카운팅레이블을누르면 터치가안먹음) 반응이 되는데, 힛테스트 통해서 전체를 눌러도 가능하도록 수정조취해야함
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = maximumPhotoNumber-photoArray.count
        
        if photoArray.count == 10 {
            print("더이상 사진을 추가할 수 없습니다.")
        }else{
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            DispatchQueue.main.async {
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func pickerDidCancel(_ picker: PHPickerViewController) {
        dismiss(animated: true, completion: nil)
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


