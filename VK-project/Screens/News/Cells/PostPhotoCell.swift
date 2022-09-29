//
//  PostPhotoCell.swift
//  VK-project
//
//  Created by Виктория Германович on 16.09.22.
//

import UIKit

class PostPhotoCell: UITableViewCell {
    
    static var reuseID = "PostPhotoCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostCellModel) {
        
        if let url = URL.init(string:  model.photoUrl) {
            photoImageView.sd_setImage(with: url)
        }
    }
}
