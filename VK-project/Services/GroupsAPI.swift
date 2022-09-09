//
//  GroupsAPI.swift
//  VK-project
//
//  Created by Виктория Германович on 30.08.22.
//

import Foundation

final class GroupsAPI {
    
    func fetchGroups(offset: Int = 0, compeltion: @escaping([Group], Int)->()){
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "order", value: "random"),
            URLQueryItem.init(name: "count", value: "50"),
            URLQueryItem.init(name: "offset", value: "\(offset)"),
            URLQueryItem.init(name: "extended", value: "1"),
            URLQueryItem.init(name: "fields", value: "members_count"),
            
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: "\(Session.shared.token)")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //print("groups: \(data?.prettyJson)")
            
            guard let jsonData = data else { return }
            let groupsResponse = try? JSONDecoder().decode(GroupsResponse.self, from: jsonData)
            let groups = groupsResponse?.response.items ?? []
            let groupsCount = groupsResponse?.response.count ?? 0
            DispatchQueue.main.async {
                compeltion(groups, groupsCount)
            }
            
        }.resume()
        
    }
}
