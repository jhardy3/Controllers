//
//  ImageController.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static let sharedInstance = ImageController()
    
    var images = [UIImage]()
    var index = 0
    
    init() {
        fetchImages()
    }
    
    func fetchImages() {
        for _ in 0...10 {
            NetworkController.fetchImageAtURL(imageURL, completion: { (image) in
                if let image = image {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.images.append(image)
                    })
                }
            })
        }
    }
    
    func fetchImage() {
        NetworkController.fetchImageAtURL(imageURL) { (image) in
            if let image = image {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.images.append(image)
                })
            }
        }
    }
    
    func indexNearEnd(index: Int) {
        if index == images.count - 5 {
            fetchImages()
        } else {
            fetchImage()
        }
    }
    
    func fetchNextImage() -> UIImage? {
        indexNearEnd(index)
        index = index + 1
        if index < images.count {
            return images[index]
        } else {
            return nil
        }
    }
    
    func fetchPreviousImage() -> UIImage {
        if index == 0 {
            return images[0]
        } else {
            index = index - 1
            return images[index]
        }
    }
}