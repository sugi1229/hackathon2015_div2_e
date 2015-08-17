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
    
    func setImage(image:UIImage) {
        self.indicator.startAnimating()
        self.indicator.hidden = false
        let semaphore = dispatch_semaphore_create(0)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            self.imageView.image = image
            dispatch_semaphore_signal(semaphore)
        })
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }

}
