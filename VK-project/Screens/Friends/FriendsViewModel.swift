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
    private var friendsArchiver = FriendsArchiverImpl()
    private var friendsCount: Int = 0
    
    func fetchFriends( bindTo tableView: UITableView) {
        Task {
            do {
                let ( friends, count ) = try await friendsAPI.fetchFriends()
                var optionalFriends: Array<Optional<Friend>> = []
                for friend in friends {
                    optionalFriends.append(friend)
                }
        
                self.friendsCount = count
                self.friendsArchiver.save(friends)
                let savedFriends = self.friendsArchiver.retrieve()
                self.friends = savedFriends
                
                await tableView.reloadData()
                
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func prefetchFriends( bindTo tableView: UITableView) {
        isFriendsLoading = true
        Task {
            do {
                let ( friends, count ) = try await friendsAPI.fetchFriends()
                self.friends.append(contentsOf: friends )
                self.friendsCount = count
                await tableView.reloadData()
                
                self.isFriendsLoading = false
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}
