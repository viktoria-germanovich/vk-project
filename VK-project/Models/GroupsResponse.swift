//
//  GroupsResponse.swift
//  VK-project
//
//  Created by Виктория Германович on 30.08.22.
//

import Foundation

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: GroupsItems
}

// MARK: - Response
struct GroupsItems: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let photo100: String
    let name: String
    let membersCount: Int?

    enum CodingKeys: String, CodingKey {
        case photo100 = "photo_100"
        case name
        case membersCount = "members_count"
    }
}
