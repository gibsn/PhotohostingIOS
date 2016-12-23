//
//  ThumbnailController.swift
//  PhotohostingIOS
//
//  Created by Kirill Alekseev on 23.12.16.
//  Copyright © 2016 Kirill Alekseev. All rights reserved.
//

import UIKit
import AlamofireImage


class ThumbnailController: UICollectionViewCell {
    @IBOutlet private weak var imgView: UIImageView!
    
    public func setUrl(_ url: URL) {
        imgView.af_setImage(withURL: url)
    }
    
}
