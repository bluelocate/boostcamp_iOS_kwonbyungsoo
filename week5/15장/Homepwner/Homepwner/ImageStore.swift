//
//  ImageStore.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 28..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage, forkey key: String) {
        cache.setObject(image, forKey: key as NSString)
        print("key 는 \(key)")
        let url = imageURLForKey(key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try? data.write(to: url, options: [.atomic])
            }
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURLForKey(key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("remove error : \(deleteError)")
        }
    }
    
    func imageURLForKey(_ key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentDirectories.first else {
            fatalError("wrong Path!")
        }
        return documentDirectory.appendingPathComponent(key)
    }
}
