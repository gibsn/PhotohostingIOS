//
//  AlbumCollectionViewController.swift
//  PhotohostingIOS
//
//  Created by Kirill Alekseev on 20.12.16.
//  Copyright © 2016 Kirill Alekseev. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"


class AlbumCollectionViewController:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private var photosFetcher = PhotosFetcher()
    private var photosArr: [Photo]?
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        photosFetcher.getPhotos() { newPhotosArr in
            if newPhotosArr != nil {
                self.photosArr = newPhotosArr
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "viewFullPhoto" {
            let indexPath = self.collectionView.indexPath(for: sender as! UICollectionViewCell)!
            
            let controller = segue.destination as! FullPhotoViewController
            controller.photoIndex = indexPath.item
            controller.photosArr = self.photosArr
            
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photosArr != nil {
            return photosArr!.count
        } else {
            return 0
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ThumbnailController

        let url = URL(string: self.photosArr![indexPath.item].thumbUrl)!
        cell.setUrl(url)

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
}
