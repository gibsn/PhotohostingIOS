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
//    private var photosThumbs [some shit] = nil
    private var photosFetcher = PhotosFetcher()
    private var photosArr: [Photo]?
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        photosFetcher.getPhotos() { newPhotosArr in
            self.photosArr = newPhotosArr
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        
        return cell
    }
}
