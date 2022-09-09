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
    
    var videosVC: VideosVC = {
        let videosVC = VideosVC()
        let videosTabBarItem = UITabBarItem()
        videosTabBarItem.image = UIImage(systemName: "video")
        videosTabBarItem.title = "Видео"
        videosVC.tabBarItem = videosTabBarItem
        
        return videosVC
    }()
    
    var groupsVC: GroupsVC = {
        let groupsVC = GroupsVC()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.image = UIImage(systemName: "person.3")
        groupsTabBarItem.title = "Группы"
        groupsVC.tabBarItem = groupsTabBarItem
        
        return groupsVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers: [UIViewController] = [friendsVC, videosVC, groupsVC]
        self.viewControllers = controllers
    }
    
}
