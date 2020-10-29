//
//  IGFeedPostActionsCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

protocol IGFeedPostActionsCellDelegate: AnyObject {
    
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsCell: UITableViewCell {

    weak var delegate: IGFeedPostActionsCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .link
        return button
    }()

    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .link
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTaplikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTaplikeButton() {
        
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        
        delegate?.didTapSendButton()
    }
    
    public func configure(with post: UserPost) {
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Configure the cell
        let buttonSize = contentView.height - 10
        let buttons = [likeButton, commentButton, sendButton]
        
        for x in 0..<buttons.count {
            
            let button = buttons[x]
            
            button.frame = CGRect(x: (CGFloat(x) * buttonSize) + (10 * CGFloat(x + 1)),
                                  y: 5,
                                  width: buttonSize,
                                  height: buttonSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
}
