//
//  NotificationLikeEventCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventCellDelegate: AnyObject {
    
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventCell: UITableViewCell {
    
    weak var delegate: NotificationLikeEventCellDelegate?
    private var model: UserNotification?
    
    // Design UI
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Emblem")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Yo Like your recipe"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Emblem"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(didTappostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeHeight = contentView.height - 6
        let size = contentView.height - 4
        
        // Phot, Text, Post Button
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: sizeHeight,
                                        height: sizeHeight)
        
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        postButton.frame = CGRect(x: contentView.width - 5 - size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: profileImageView.right + 5,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    @objc private func didTappostButton() {
        
        guard let model = model else { return }
        
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configuration(with model: UserNotification) {
        
        self.model = model
        
        switch model.type {
            
        case .like(let post):
            
            let thumbnail = post.thumbnailImage
            
            guard !thumbnail.absoluteString.contains("google.com") else { return }
            
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
            
        case .follow:
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
}
