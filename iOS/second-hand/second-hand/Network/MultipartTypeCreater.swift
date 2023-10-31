//
//  MultipartTypeCreater.swift
//  second-hand
//
//  Created by SONG on 2023/10/30.
//

import UIKit

class MultipartTypeCreater {
    func createMultipartData(image: UIImage, boundary: String) -> Data {
        let imageData = image.jpegData(compressionQuality: 0.8) 
        var body = Data()

        if let imageData = imageData {
            let boundaryString = "--\(boundary)\r\n"
            body.append(Data(boundaryString.utf8))

            let fileHeader = "Content-Disposition: form-data; name=\"profileImage\"; filename=\"0.jpg\"\r\n"
            body.append(fileHeader.data(using: .utf8)!)

            let contentType = "Content-Type: image/jpeg\r\n\r\n"
            body.append(contentType.data(using: .utf8)!)

            // 이미지 데이터를 추가
            body.append(imageData)
            
            body.append("\r\n".data(using: .utf8)!)
            // 마지막 boundary 추가
            let finalBoundaryString = "--\(boundary)--\r\n"
            body.append(finalBoundaryString.data(using: .utf8)!)
        }
       
        return body
    }

}
