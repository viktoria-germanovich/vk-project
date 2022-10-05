//
//  PostCellModel.swift
//  VK-project
//
//  Created by Виктория Германович on 19.09.22.
//

import Foundation

struct PostCellModel {
    //MARK: - Author
    var authorName: String
    var authorImageUrl: String
    
    //MARK: - Text
    var text: String
    
    //MARK: - Photo
    var photoUrl: String
    var aspectRatio: Double 
    
    //MARK: - Likes and Views
    var likesCount: Int
    var viewsCount: Int
}
