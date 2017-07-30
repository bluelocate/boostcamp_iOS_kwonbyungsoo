//
//  ImageStore.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 15..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit
class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage, forkey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
