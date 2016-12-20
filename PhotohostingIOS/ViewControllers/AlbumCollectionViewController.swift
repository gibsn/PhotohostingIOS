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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = UIColor.red
        return cell
    }
}
