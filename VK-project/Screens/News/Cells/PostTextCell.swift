//
//  PostTextCell.swift
//  VK-project
//
//  Created by Виктория Германович on 16.09.22.
//

import UIKit

class PostTextCell: UITableViewCell {
    
    static var reuseID = "PostTextCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping 
        label.numberOfLines = 0
        
        return label
    }()
    
    override func prepareForReuse() {
        titleLabel.text = nil
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
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Public
    func configure(_ model: PostCellModel) {
        
        titleLabel.text = model.text
    }
    
    
}
