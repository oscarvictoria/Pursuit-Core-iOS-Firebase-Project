//
//  CellectionCell.swift
//  Pursuit-Core-iOS-Firebase-Project
//
//  Created by Oscar Victoria Gonzalez  on 3/10/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    public func configure(for photo: Photo) {
        captionLabel.text = photo.caption
        imageView.kf.setImage(with: URL(string: photo.imageURL))
    }
    
    
    
}
