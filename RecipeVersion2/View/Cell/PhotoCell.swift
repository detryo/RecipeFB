//
//  PhotoCell.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SDWebImage

class PhotoCell: UITableViewCell {

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
    
    
}
