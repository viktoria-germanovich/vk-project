//
//  FriendsAPI.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import Foundation

final class FriendsAPI {
    
    func fetchFriends(offset: Int = 0 , compeltion: @escaping([Friend], Int)->()){
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "order", value: "hints"),
            URLQueryItem.init(name: "count", value: "50"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            URLQueryItem.init(name: "fields", value: "photo_100,online"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: "\(Session.shared.token)")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            let friendsResponse = try? JSONDecoder().decode(FriendsResponse.self, from: jsonData)
            let friends = friendsResponse?.response.items ?? []
            let friendsCount = friendsResponse?.response.count ?? 0
            
            DispatchQueue.main.async {
                compeltion(friends, friendsCount)
            }
            
        }.resume()
        
    }
}
