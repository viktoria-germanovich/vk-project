//
//  GroupsVC.swift
//  VK-project
//
//  Created by Виктория Германович on 30.08.22.
//

import UIKit

final class GroupsVC: UIViewController {

    //MARK: - properties
    private var viewModel = GroupsViewModel()

    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseId)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        viewModel.fetchGroups(bindTo: tableView)
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
        viewModel.fetchGroups(bindTo: tableView)
        refreshControl.endRefreshing()
    }
}
//MARK: - UITableViewDataSource
extension GroupsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as! GroupCell

        let group = viewModel.groups[indexPath.row]
        cell.configure(group)

        return cell
    }

}

//MARK: - UITableViewDataSourcePrefetching
extension GroupsVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let maxRow = indexPaths
            .map { $0.last ?? 0 }
            .max() ?? 0

        if viewModel.isGroupsLoading == false, maxRow == viewModel.groups.count - 5, viewModel.groupsCanLoad {
            viewModel.prefetchGroups(bindTo: tableView)
        }
    }
}
