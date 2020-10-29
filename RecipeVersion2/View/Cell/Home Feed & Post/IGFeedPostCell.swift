//
//  IGFeedPostCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SDWebImage
import AVFoundation

// Cell for primary post content
final class IGFeedPostCell: UITableViewCell {

    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    // Design UI
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // importante que el layer este primero
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        
        postImageView.image = UIImage(named: "Emblem")
        
        return
        
        // Configure the cell
        switch post.postType {
        
        case .photo:
        // Show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
            
        case .video:
        // Load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = nil
    }
}
