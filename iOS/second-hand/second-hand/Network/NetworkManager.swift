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
    
    func requestGET(fromURL url: URL, completion: @escaping (Result<Codable, Error>) -> Void) {
        
        let asyncCompletion: (Result<Codable, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = HttpMethod.get.method
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                
                print(String(data: data!, encoding: .utf8))
                guard let urlResponse = response as? HTTPURLResponse else {
                    return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                }
                switch urlResponse.statusCode {
                case 401 :
                    let responseData = try JSONDecoder().decode(GitUserJoinDTO.self, from: data!)
                    asyncCompletion(.success(responseData.body))
                case 200..<300 :
                    let responseData = try JSONDecoder().decode(GitUserLoginDTO.self, from: data!)
                    asyncCompletion(.success(responseData.body))
                default :
                    return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                }
            } catch {
                asyncCompletion(.failure(error))
            }
        }
        session.resume()
    }
    
    func requestPOST(data: Data?, fromURL url: URL, completion: @escaping (Result<Codable, Error>) -> Void) {
            
            let asyncCompletion: (Result<Codable, Error>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            var request = URLRequest(url: url, timeoutInterval: 10.0)
            request.httpMethod = HttpMethod.post.method
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            request.httpBody = data
            
            let session = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let urlResponse = response as? HTTPURLResponse else {
                        return asyncCompletion(.failure(ManagerErrors.invalidResponse))
                    }
                    switch urlResponse.statusCode {
                    case 200..<300 :
                        print(String(data: data!, encoding: .utf8))
                    default :
                        return asyncCompletion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
                    }
            }
            session.resume()
        }
}

