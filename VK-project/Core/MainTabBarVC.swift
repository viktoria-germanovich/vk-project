//
//  MainTabBarVC.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import UIKit

class MainTabBarVC: UITabBarController {

    var friendsVC: FriendsVC = {
        let friendsVC = FriendsVC()
        let friendsTabBarItem = UITabBarItem()
        friendsTabBarItem.image = UIImage(systemName: "person.2")
        friendsTabBarItem.title = "Друзья"
        friendsVC.tabBarItem = friendsTabBarItem
        
        return friendsVC
    }()
    
    var groupsVC: GroupsVC = {
        let groupsVC = GroupsVC()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.image = UIImage(systemName: "person.3")
        groupsTabBarItem.title = "Группы"
        groupsVC.tabBarItem = groupsTabBarItem
        
        return groupsVC
    }()
    
    var newsVC: NewsFeedVC = {
        let groupsVC = NewsFeedVC()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.image = UIImage(systemName: "newspaper")
        groupsTabBarItem.title = "Новости"
        groupsVC.tabBarItem = groupsTabBarItem
        
        return groupsVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers: [UIViewController] = [friendsVC, groupsVC, newsVC]
        self.viewControllers = controllers
    }
    
}
