//
//  GIthubWebViewController.swift
//  second-hand
//
//  Created by leehwajin on 2023/06/14.
//

import UIKit
import WebKit
import OSLog

final class GithubWebViewController: UIViewController {
    private let networkManager = NetworkManager()
    private let logger = Logger()
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        startOAuthFlow()
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func startOAuthFlow() {
        initializeWebViewCahChe()
        let authURLString = Server.shared.oAuthAuthorizeURL()
        
        if let authURL = URL(string: authURLString) {
            let authRequest = URLRequest(url: authURL,timeoutInterval: 30.0) // 예처
            webView.load(authRequest)
        }
    }
    
    private func handleRedirectURL(url: URL) {
        guard let accessToken = extractAccessToken(from: url) else {
            return
        }
        logger.log("\naccess token: \(accessToken)")
        
        guard let accessURL = URL(string:Server.shared.gitLoginURL(withCode: accessToken)) else {
            return
        }
        
        guard let joinURL = URL(string:Server.shared.url(for: .join)) else {
            return
        }
        
        networkManager.sendOAuthGET(fromURL: accessURL) { (result: Result<[Codable], Error>) in
            switch result {
            case .success(let user):
                if user.count == 2 {
                    self.joinFlow(with: user, path: joinURL)
                } else {
                    self.loginFlow(with: user)
                }
                
            case .failure(let error):
                self.logger.log("FAIL \(error.localizedDescription)")
            }
        }
    }
    
    private func extractAccessToken(from url: URL) -> String? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                if item.name == "code" {
                    return item.value
                }
            }
        }
        return nil
    }
    
    private func joinFlow(with userData: [Codable],path: URL) {
        let region = Region(id: 1, onFocus: true)
        let jsonCreater = JSONCreater()
        
        guard let cookie = userData.first as? ResponseHeader else {
            return
        }
        guard let requestDataToJoin = userData.last! as? GitUserNeedsJoin else {
            return
        }
        
        self.networkManager.sendOAuthPOST(data: jsonCreater.createJSON(user: requestDataToJoin, region: region),header: cookie, fromURL: path) { (result: Result<Codable, Error>) in
            switch result {
            case .success(_) :
                print("가입성공")
            case .failure(let error) :
                self.logger.log("FAIL \(error.localizedDescription)")
            }
        }
    }
    
    private func loginFlow(with user :[Codable]) {
        guard let loginDataFetched = user.last as? LoginFetchedUserData else {
            return
        }
        UserInfoManager.shared.updateData(from: loginDataFetched)
        print(UserInfoManager.shared.userInfo)
    }
    
    private func initializeWebViewCahChe() {
        let configuration = webView.configuration
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            for record in records {
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        
    }
}


extension GithubWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            handleRedirectURL(url: url)
        }
        decisionHandler(.allow)
    }
}


//// MARK: - 에러처리 일단 주석 
//
//extension GithubWebViewController {
//    private func handleNetworkServiceError(with statusCode: Int) {
//        let errorStatusCode = ManagerErrors.statuscode(rawValue: statusCode)
//
//        switch errorStatusCode {
//        case .internalServerError:
//            // something => 500번대 에러에 대한 처리
//        case .notFound:
//            // something => => 사용자한테 표시해야하는 에러
//        }
//    }
//}
