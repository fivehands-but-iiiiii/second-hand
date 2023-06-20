//
//  NetworkManager.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation
import OSLog

class NetworkManager {
    let logger = Logger()
    
    func requestGET(fromURL url: URL, completion: @escaping (Result<[Codable], Error>) -> Void) {
        
        let asyncCompletion: (Result<[Codable], Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = HttpMethod.get.method
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                guard let data = data else {
                    return
                }
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                }
                
                switch urlResponse.statusCode {
                case 401 :
                    let responseData = try JSONDecoder().decode(GitUserJoinDTO.self, from: data)
                    
                    guard let header = self.decodeHeader(httpResponse: urlResponse) else {
                        return
                    }
                    
                    asyncCompletion(.success([header,responseData.body]))
                case 200..<300 :
                    let responseData = try JSONDecoder().decode(GitUserLoginDTO.self, from: data)
                    asyncCompletion(.success([responseData.data]))
                default :
                    return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                }
            } catch {
                asyncCompletion(.failure(error))
            }
        }
        session.resume()
    }
    
    func requestPOST(data: Data?, header: ResponseHeader, fromURL url: URL, completion: @escaping (Result<Codable, Error>) -> Void) {
        
        let asyncCompletion: (Result<Codable, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let keyOfSetCookie : String = ResponseHeader.CodingKeys.setCookie.rawValue
        let valueOfSetCookie : String = header.setCookie.description

        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = HttpMethod.post.method
        request.allHTTPHeaderFields = ["Cookie" : valueOfSetCookie,"Content-Type":"application/json"]
        request.httpBody = data
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let urlResponse = response as? HTTPURLResponse else {
                return asyncCompletion(.failure(ManagerErrors.invalidResponse))
            }
            print(urlResponse.statusCode)
            switch urlResponse.statusCode {
            case 200..<300 :
            print("POST 성공 ",String(data: data!, encoding: .utf8))
                return asyncCompletion(.success(data))
            default :
                return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
        }
        session.resume()
    }
    
    private func decodeHeader(httpResponse : HTTPURLResponse) -> Codable? {
        do {
            let setCookieHeaders = httpResponse.allHeaderFields.filter { key, _ in
                if let headerKey = key as? String {
                    return headerKey.lowercased() == "set-cookie"
                }
                return false
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: setCookieHeaders, options: [])
            
            // JSON decoding
            let decoder = JSONDecoder()
            let responseHeader = try decoder.decode(ResponseHeader.self, from: jsonData)
            //print(responseHeader.setCookie)
            return responseHeader
        } catch {
            print("JSON 디코딩 에러: \(error)")
            return nil
        }
    }
}

