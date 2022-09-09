//
//  FriendsViewModel.swift
//  VK-project
//
//  Created by Виктория Германович on 7.09.22.
//

import Foundation
import UIKit

final class FriendsViewModel {
    
    var friends: [Friend] = []
    var isFriendsLoading = false
    var friendsCanLoad: Bool {
        return friends.count < friendsCount
    }
    
    private var friendsAPI = FriendsAPI()
    private var friendsCount: Int = 0
    
    func fetchFriends( bindTo tableView: UITableView) {
        friendsAPI.fetchFriends { friends, count in
            self.friends = friends
            self.friendsCount = count
            tableView.reloadData()
        }
    }
    
    func prefetchFriends( bindTo tableView: UITableView) {
        isFriendsLoading = true
        friendsAPI.fetchFriends(offset: friends.count) { friends, count in
            self.friends.append(contentsOf: friends )
            self.friendsCount = count
            tableView.reloadData()
            
            self.isFriendsLoading = false
        }
    }
}
