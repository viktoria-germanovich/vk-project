//
//  NewsFeedAPI.swift
//  VK-project
//
//  Created by Виктория Германович on 19.09.22.
//

import Foundation

final class NewsFeedAPI {
    
    func fetchPosts(offset: Int = 0, compeltion: @escaping([PostCellModel])->()){
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "filters", value: "post,photo,friend,photo_tag,wall_photo,note"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                guard let jsonData = data else { return }
                let postResponse = try JSONDecoder().decode(PostResponse.self, from: jsonData)
                
                let posts = postResponse.response.items
                let profiles = postResponse.response.profiles
                let groups = postResponse.response.groups
                
                var cellModels: [PostCellModel] = []
                
                for post in posts {
                    
                    if post.postType != "post" { continue }
                    
                    let text = post.text ?? ""
                    let likesCount = post.likes?.count ?? 0
                    let viewsCount = post.views?.count ?? 0
                    
                    let photoUrl = post.attachments?.first?.photo?.sizes.last?.url ?? ""
                    
                    let photoHeight = post.attachments?.first?.photo?.sizes.last?.height ?? 0
                    let photoWidth = post.attachments?.first?.photo?.sizes.last?.width ?? 0
                    
                    let aspectRatio = Double(photoHeight) / Double(photoWidth)
                    
                    var authorName = ""
                    var authorImageUrl = ""
                    
                    if post.sourceID < 0 {
                        let group = groups?.first(where: { $0.id == abs(post.sourceID) } )
                        authorName = group?.name ?? ""
                        authorImageUrl = group?.photo200 ?? ""
                        
                    } else {
                        let profile = profiles?.first(where: { $0.id == post.sourceID})
                        authorName = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
                        authorImageUrl = profile?.photo100 ?? ""
                    }
                    let cellModel = PostCellModel.init(authorName: authorName,
                                                       authorImageUrl: authorImageUrl,
                                                       text: text,
                                                       photoUrl: photoUrl,
                                                       aspectRatio: aspectRatio,
                                                       likesCount: likesCount,
                                                       viewsCount: viewsCount )
                    cellModels.append(cellModel)
                }
                DispatchQueue.main.async {
                    compeltion(cellModels)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
