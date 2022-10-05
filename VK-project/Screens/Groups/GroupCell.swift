//
//  GroupCell.swift
//  VK-project
//
//  Created by Виктория Германович on 30.08.22.
//

import UIKit
import SDWebImage

protocol GroupCellInput {
    func configure(_ model: Group)
}
class GroupCell: UITableViewCell, GroupCellInput {
    
    //MARK: - internal properties
    static let reuseId = "GroupCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    var membersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(membersCountLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private
    private func setupViews(){
        contentView.addSubview(photoImageView)
        contentView.addSubview(infoStackView)
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            infoStackView.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            infoStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - public
    func configure(_ model: Group) {
        
        let url = URL.init(string: model.photo100)
        photoImageView.sd_setImage(with: url)
        
        nameLabel.text = "\(model.name)"
        membersCountLabel.text = "\(model.membersCount ?? 0) участников"
    }
}
