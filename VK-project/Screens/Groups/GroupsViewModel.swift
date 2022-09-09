//
//  GroupsViewModel.swift
//  VK-project
//
//  Created by Виктория Германович on 7.09.22.
//

import Foundation
import UIKit

final class GroupsViewModel {
    
    var groups: [Group] = []
    var isGroupsLoading = false
    var groupsCanLoad: Bool {
        return groups.count < groupsCount
    }
    
    private var groupsAPI = GroupsAPI()
    private var groupsCount: Int = 0
    
    func fetchGroups( bindTo tableView: UITableView) {
        groupsAPI.fetchGroups { groups, count in
            self.groups = groups
            self.groupsCount = count
            tableView.reloadData()
        }
    }
    
    func prefetchGroups( bindTo tableView: UITableView) {
        isGroupsLoading = true
        groupsAPI.fetchGroups(offset: groups.count) { groups, count in
            self.groups.append(contentsOf: groups)
            self.groupsCount = count
            tableView.reloadData()
            
            self.isGroupsLoading = false
        }
    }
}
