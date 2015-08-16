//
//  PhotoAlbumViewController.swift
//  MealBird
//
//  Created by minami on 8/16/15.
//  Copyright (c) 2015 div2_e. All rights reserved.
//

import UIKit

class PhotoAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = Photo.MR_findAll()
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : PhotoAlbumCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell",
                                            forIndexPath: indexPath) as! PhotoAlbumCollectionViewCell

        if let photo = photos[indexPath.item] as? Photo {
            let image = UIImage(data: photo.image)
            cell.imageView.image = image
            cell.imageView.transform = CGAffineTransformMakeRotation(CGFloat(90.0 * M_PI / 180))
            cell.backgroundColor = UIColor.lightTextColor()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        println("Num: \(indexPath.row)")
        println("Value:\(collectionView)")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
