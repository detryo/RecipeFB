//
//  NotificationFollowEventCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

protocol NotificationFollowEventCellDelegate: AnyObject {
    
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventCell: UITableViewCell {

    weak var delegate: NotificationFollowEventCellDelegate?
    private var model: UserNotification?
    
    // Design UI
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Alguien te sigue por tus recetas"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        contentView.addSubview(label)
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        configureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeHeight = contentView.height - 6
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        
        // Phot, Text, Post Button Frames
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: sizeHeight,
                                        height: sizeHeight)
        
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        followButton.frame = CGRect(x: contentView.width - 5 - size,
                                    y: (contentView.height - buttonHeight) / 2,
                                    width: size,
                                    height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 5,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    @objc private func didTapFollowButton() {
        
        guard let model = model else { return }
        
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    public func configuration(with model: UserNotification) {
        
        self.model = model
        
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            // configure button
        
            switch state {
            case .following:
            // Show unFollow button
            configureForFollow()
                
            case .no_following:
            // Show Follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.backgroundColor = .link
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configureForFollow() {
        
        followButton.setTitle("UnFollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
}
