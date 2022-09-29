//
//  NewsFeedVC.swift
//  VK-project
//
//  Created by Виктория Германович on 16.09.22.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likes
}

final class NewsFeedVC: UIViewController {
    
    var posts: [PostCellModel] = []
    var newsFeedAPI = NewsFeedAPI()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostAuthorCell.self, forCellReuseIdentifier: PostAuthorCell.reuseID)
        tableView.register(PostTextCell.self, forCellReuseIdentifier: PostTextCell.reuseID)
        tableView.register(PostPhotoCell.self, forCellReuseIdentifier: PostPhotoCell.reuseID)
        tableView.register(PostLikesCell.self, forCellReuseIdentifier: PostLikesCell.reuseID)
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPosts()
    }
    
    //MARK: - Requests
    private func fetchPosts() {
        newsFeedAPI.fetchPosts { [ weak self] posts in
            guard let self = self else { return }
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        tableView.pinEdgesToSuperview()
    }
}

extension NewsFeedVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.section]
        if let cellType = PostCellType.init(rawValue: indexPath.row) {
            switch cellType {
            case .text:
                return post.text.isEmpty ? 0 : UITableView.automaticDimension
            case .photo:
                return post.photoUrl.isEmpty ? 0 : UIScreen.main.bounds.width * post.aspectRatio
                
            default: return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
}

extension NewsFeedVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostCellType.allCases.count //4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //1 новость - 1 секция
        let post = posts[indexPath.section]
        
        if let cellType = PostCellType.init(rawValue: indexPath.row) {
            
            switch cellType {
            case .author:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: PostAuthorCell.reuseID, for: indexPath) as! PostAuthorCell
                
                cell.configure(post)
                return cell
                
            case .text:
                let cell = tableView.dequeueReusableCell(withIdentifier: PostTextCell.reuseID, for: indexPath) as! PostTextCell
                
                cell.configure(post)
                return cell
                
            case .photo:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: PostPhotoCell.reuseID, for: indexPath) as! PostPhotoCell
                cell.configure(post)
                return cell
                
            case .likes:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: PostLikesCell.reuseID, for: indexPath) as! PostLikesCell
                cell.configure(post)
                return cell
                
            }
        }
        return UITableViewCell()
    }
}
