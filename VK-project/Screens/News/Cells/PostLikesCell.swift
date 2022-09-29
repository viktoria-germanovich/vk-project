//
//  PostLikesCell.swift
//  VK-project
//
//  Created by Виктория Германович on 16.09.22.
//

import UIKit

class PostLikesCell: UITableViewCell {
    
    static var reuseID = "PostLikesCell"
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "♡ 0"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 views"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func prepareForReuse() {
        likesLabel.text = nil
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(viewsLabel)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: PostCellModel) {
        likesLabel.text = "♡ \(model.likesCount)"
        viewsLabel.text = "\(model.viewsCount) views"
    }
    
}
