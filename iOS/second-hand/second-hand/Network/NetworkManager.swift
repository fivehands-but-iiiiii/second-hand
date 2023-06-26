//
//  NetworkManager.swift
//  second-hand
//
//  Created by SONG on 2023/06/15.
//

import Foundation
import OSLog
import UIKit

class NetworkManager {
    let logger = Logger()
    

    func sendOAuthGET(fromURL url: URL, completion: @escaping (Result<[Codable], Error>) -> Void) {
        
        let asyncCompletion: (Result<[Codable], Error>) -> Void = { result in

            DispatchQueue.main.async {
                completion(result)
            }
        }
      
        var request = URLRequest(url: url, timeoutInterval: 30.0)
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
                    let responseData = try JSONDecoder().decode(LoginSuccess.self, from: data)
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
    

    func sendOAuthPOST(data: Data?, header: ResponseHeader, fromURL url: URL, completion: @escaping (Result<Codable, Error>) -> Void) {
        
        let asyncCompletion: (Result<Codable, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let keyOfCookie : String = "Cookie"
        let valueOfCookie : String = header.setCookie.description
        
        var request = URLRequest(url: url, timeoutInterval: 30.0)
        request.httpMethod = HttpMethod.post.method
        request.allHTTPHeaderFields = [keyOfCookie : valueOfCookie,JSONCreater.headerKeyRequired:JSONCreater.headerValueRequired]
        request.httpBody = data

        let session = URLSession.shared.dataTask(with: request) { data, response, error in

            do {
                guard let urlResponse = response as? HTTPURLResponse else {
                    return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                }
                
                guard let data = data else {
                    return
                }
                
                switch urlResponse.statusCode {
                case 200..<300 :
                    let responseHeader = try JSONDecoder().decode(JoinSuccess.self, from: data)
                    return asyncCompletion(.success(responseHeader ))
                default :
                    return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                }
            } catch {
                
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

            let decoder = JSONDecoder()
            let responseHeader = try decoder.decode(ResponseHeader.self, from: jsonData)

            return responseHeader
        } catch {
            print("JSON 디코딩 에러: \(error)")
            return nil
        }
    }
    
    //MARK: 위에꺼 싹다 분리 후 제네릭으로 개조 예정
    
    func sendGET<T:Codable> (decodeType:T.Type,what data :Data?, fromURL url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        
        let asyncCompletion: (Result<[T], Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        var request = URLRequest(url: url, timeoutInterval: 30.0)
        request.httpMethod = HttpMethod.get.method
        request.httpBody = data
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else {
                    return
                }
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                }
                
                switch urlResponse.statusCode {
                case 200..<300 :
                    let answer = try JSONDecoder().decode(decodeType, from: data)
                    asyncCompletion(.success([answer]))
                default :
                    return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                }
            } catch {
                asyncCompletion(.failure(error))
            }
        }
        session.resume()
    }
    
    static func sendGETImage(fromURL url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ManagerErrors.invalidResponse))
                return
            }
            
            completion(.success(image))
        }
        session.resume()
    }
    
    func sendPOST<T:Codable>(decodeType:T.Type ,what data: Data?, header: ResponseHeader?, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        
        let asyncCompletion: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        guard let data = data else {
            return
        }
        
        let request = makeRequestPOST(header: header, url: url, body: data)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else {
                    return
                }
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                }

                switch urlResponse.statusCode {
                case 200..<300 :
                    let answer = try JSONDecoder().decode(T.self, from: data)
                    return asyncCompletion(.success(answer))
                default :
                    return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                }
                
            } catch {
                asyncCompletion(.failure(error))
            }
        }
        session.resume()
    }
    
    private func makeRequestPOST(header: ResponseHeader?, url: URL, body: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.method
        request.httpBody = body
        
        if let header = header {
            let keyOfCookie : String = "Cookie"
            let valueOfCookie : String = header.setCookie.description
            request.allHTTPHeaderFields = [keyOfCookie: valueOfCookie,JSONCreater.headerKeyRequired:JSONCreater.headerValueRequired]
    
            return request
        } else {
            request.allHTTPHeaderFields = [JSONCreater.headerKeyRequired:JSONCreater.headerValueRequired]
            
            return request
        }
    }
}
