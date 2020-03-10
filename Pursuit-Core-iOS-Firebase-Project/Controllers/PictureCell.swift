//
//  PictureCell.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/10/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    public func configure(for photo: Photo) {
        pictureView.kf.setImage(with: URL(string: photo.imageURL))
        captionLabel.text = photo.caption
        
    }
    
    
}


