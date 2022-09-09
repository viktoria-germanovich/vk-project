//
//  FriendsResponse.swift
//  VK-project
//
//  Created by Виктория Германович on 30.08.22.
//

import Foundation

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: FriendsItems
}

// MARK: - Response
struct FriendsItems: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Friend
struct Friend: Codable {
    let photo100: String
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case photo100 = "photo_100"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
