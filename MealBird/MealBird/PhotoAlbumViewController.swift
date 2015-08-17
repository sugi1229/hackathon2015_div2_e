//
//  PhotoAlbumViewController.swift
//  MealBird
//
//  Created by minami on 8/16/15.
//  Copyright (c) 2015 div2_e. All rights reserved.
//

import UIKit

class PhotoAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        photos = Photo.MR_findAll()
        collectionView.reloadData()
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
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        println("Num: \(indexPath.row)")
        println("Value:\(collectionView)")
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let oneSide = self.view.frame.size.width - 10
        return CGSizeMake(oneSide, oneSide)
    }
    
}
