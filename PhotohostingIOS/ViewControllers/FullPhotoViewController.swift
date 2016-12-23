//
//  FullPhotoViewController.swift
//  PhotohostingIOS
//
//  Created by Kirill Alekseev on 20.12.16.
//  Copyright © 2016 Kirill Alekseev. All rights reserved.
//

import UIKit


class FullPhotoViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    public var photoIndex: Int = -1
    public var photosArr: [Photo]?
    
    @IBAction func ActionButton(_ sender: UIBarButtonItem) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnTap = true
        
        let url = URL(string: self.photosArr![photoIndex].originalUrl)!
        imgView.af_setImage(withURL: url)
    }
}
