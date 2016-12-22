//
//  PageParser.swift
//  PhotohostingIOS
//
//  Created by Kirill Alekseev on 05.12.16.
//  Copyright © 2016 Kirill Alekseev. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

//              <img src="/thumbnails/ADAM-6_resized.png" alt="/thumbnails/ADAM-6_resized.png">
//              <a href="/photos/qwe/ADAM-6.jpg">
struct Photo {
    var thumbUrl: String
    var originalUrl: String
    
    init(_ thumb: String, _ original: String) {
        thumbUrl = thumb
        originalUrl = original
    }
}

class PhotosFetcher {
    private let URL = "http://gibsn.intelib.org/album/posvyat.html"
    private var photosArr: [Photo]? = nil

    private func parsePage(_ pageText: String) -> [Photo]? {
        do {
            let pattern = "<a href=\"(.*jpg)\">\n.*\n.*<img src=\"(.*png)\" alt"
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = pageText as NSString
            let matches = regex.matches(in: pageText, range: NSRange(location: 0, length: nsString.length))
            
            var newPhotosArr: [Photo]? = {
                if matches.count > 0 {
                    return []
                } else {
                    return nil
                }
            }()
            
            
            for match in matches {
                let originalUrl = self.URL + nsString.substring(with: match.rangeAt(1))
                let thumbUrl = self.URL + nsString.substring(with: match.rangeAt(2))
                newPhotosArr?.append(Photo(thumbUrl, originalUrl))
            }
            
            return newPhotosArr
        } catch {
            NSLog("Invalid regex")
            return nil
        }
    }
    
    public func getPhotos(completionHandler: @escaping ([Photo]?) -> Void) {
        if photosArr == nil {
            Alamofire.request(URL).response { response in
                if let data = response.data, let pageText = String(data: data, encoding: .utf8) {
                    NSLog("Got HTML %@", self.URL)
                    self.photosArr = self.parsePage(pageText)
                    NSLog("Finished parsing web-page")
                    
                    completionHandler(self.photosArr)
                } else {
                    NSLog("Could not get the page with the photos")
                }
            }
        }
    }
}
