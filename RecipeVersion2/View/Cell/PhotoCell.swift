//
//  PhotoCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {

    private let photoImageView: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.clipsToBounds = true
        imageVIew.contentMode = .scaleAspectFill
        return imageVIew
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        photoImageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-Tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: UserPost) {
        
        let url = model.thumbnailImage
        
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configureDebugg(debug imageName: String) {
        
        photoImageView.image = UIImage(named: "Emblem")
    }
}
