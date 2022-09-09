//
//  FriendsVC.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import UIKit

final class FriendsVC: UIViewController {

    //MARK: - properties
    private var viewModel = FriendsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseId)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        viewModel.fetchFriends(bindTo: tableView)
    }
    
    //MARK: - private
    private func setupViews(){
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        tableView.pinEdgesToSuperview(0)
    }
    
    //MARK: - Actions
    @objc func pullToRefreshAction(){
        refreshControl.beginRefreshing()
        viewModel.fetchFriends(bindTo: tableView)
        refreshControl.endRefreshing()
    }

}
//MARK: - UITableViewDataSource
extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseId, for: indexPath) as! FriendCell
        
        let friend = viewModel.friends[indexPath.row]
        cell.configure(friend)
        
        return cell
    }
    
}
//MARK: - UITableViewDataSourcePrefetching
extension FriendsVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let maxRow = indexPaths
            .map { $0.last ?? 0 }
            .max() ?? 0

        if viewModel.isFriendsLoading == false, maxRow == viewModel.friends.count - 5, viewModel.friendsCanLoad {
            viewModel.prefetchFriends(bindTo: tableView)
        }
    }
}
