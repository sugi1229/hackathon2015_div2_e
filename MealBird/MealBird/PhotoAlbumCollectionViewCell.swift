//
//  PhotoAlbumCollectionViewCell.swift
//  MealBird
//
//  Created by minami on 8/16/15.
//  Copyright (c) 2015 div2_e. All rights reserved.
//

import UIKit

class PhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(90.0 * M_PI / 180))
    }
}
