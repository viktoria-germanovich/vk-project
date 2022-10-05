//
//  PostAuthorCell.swift
//  VK-project
//
//  Created by Виктория Германович on 16.09.22.
//

import UIKit
import SnapKit
import SDWebImage

class PostAuthorCell: UITableViewCell {
    
    static var reuseID = "PostAuthorCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail //троеточие
        
        return label
    }()
    
    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = nil
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
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostCellModel) {
        
        nameLabel.text = model.authorName
        
        if let url = URL.init(string:  model.authorImageUrl) {
            photoImageView.sd_setImage(with: url)
        }
    }
}


