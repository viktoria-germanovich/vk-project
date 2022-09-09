//
//  ViewController.swift
//  VK-project
//
//  Created by Виктория Германович on 26.08.22.
//

import UIKit
import WebKit
//OAuth

class AuthVC: UIViewController {

    //MARK: - Properties
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        return webView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        //loadURL()
        authorizeVK()
    }
    
    //MARK: - Private
    private func setupViews(){
        view.addSubview(webView)
        
    }
    
    private func setupConstraints() {
        webView.pinEdgesToSuperview(0)
    }

    private func authorizeVK(){
    //https://oauth.vk.com/authorize?client_id=1&display=page&redirect_uri=http://example.com/callback&scope=friends&response_type=code&v=5.131
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "client_id", value: "8203478"),
            URLQueryItem.init(name: "display", value: "mobile"),
            URLQueryItem.init(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem.init(name: "scope", value: "friends,photos,audio,video,wall,groups"),
            URLQueryItem.init(name: "response_type", value: "token"),
            URLQueryItem.init(name: "revoke", value: "1"),
            URLQueryItem.init(name: "v", value: "5.131")]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest.init(url: url)
        webView.load(request)
    }

}

extension AuthVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            print("observe url - >", navigationResponse.response.url ?? " " )
            decisionHandler(.allow)
            return }
        
        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=")}.reduce(Dictionary<String, String>()) {
            partialResult, param in
            
            var dict = partialResult
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
        
        guard let token = params["access_token"], let expiresIn = params["expires_in"], let userId = params["user_id"] else { return }
        
        Session.shared.token = token
        Session.shared.expiresIn = Int(expiresIn) ?? 0
        Session.shared.userId = Int(userId) ?? 0
        
        let mainTabBarVC = MainTabBarVC()
        self.navigationController?.pushViewController(mainTabBarVC, animated: true)
        
        decisionHandler(.cancel)
    }
}

