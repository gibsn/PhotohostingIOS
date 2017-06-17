//
//  PageParser.swift
//  PhotohostingIOS
//
//  Created by Kirill Alekseev on 05.12.16.
//  Copyright © 2016 Kirill Alekseev. All rights reserved.
//

import Foundation
import Alamofire


struct Photo {
    var thumbUrl: String
    var originalUrl: String
    
    init(_ thumb: String, _ original: String) {
        thumbUrl = thumb
        originalUrl = original
    }
}

class PhotosFetcher {
    private var root: String
    
    init(_ _root: String) {
        root = _root
    }

    private func parsePage(_ pageText: String) -> [Photo]? {
        do {
            let pattern = "<a href=\"(.*jpg)\">\n.*\n.*<img src=\"(.*jpg)\" alt"
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = pageText as NSString
            let matches = regex.matches(in: pageText, range: NSRange(location: 0, length: nsString.length))
            
            var newPhotosArr: [Photo]? = matches.count > 0 ? [] : nil

            for match in matches {
                let originalUrl = self.root + nsString.substring(with: match.rangeAt(1))
                let thumbUrl = self.root + nsString.substring(with: match.rangeAt(2))
                newPhotosArr?.append(Photo(thumbUrl, originalUrl))
            }
            
            return newPhotosArr
        } catch {
            NSLog("Invalid regex")
            return nil
        }
    }
    
    public func getPhotos(relativeUrl: String, completionHandler: @escaping ([Photo]?) -> Void) {
        Alamofire.request(self.root + relativeUrl).response { response in
            if let data = response.data, let pageText = String(data: data, encoding: .utf8) {
                NSLog("Got HTML %@", self.root + relativeUrl)

                let photos = self.parsePage(pageText)
                NSLog("Finished parsing web-page")
                
                completionHandler(photos)
            } else {
                NSLog("Could not get page with the photos")
            }
        }
    }
}
