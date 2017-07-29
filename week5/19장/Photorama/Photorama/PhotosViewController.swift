//
//  PhotosViewController.swift
//  Photorama
//
//  Created by byung-soo kwon on 2017. 7. 29..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store?.fetchRecentPhotos {
            (PhotosResult) -> Void in
            switch PhotosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos")
                if let firstPhoto = photos.first {
                    self.updateImageVIew(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching recent photos \(error)")
            }
        }
    }
    
    func updateImageVIew(for photo: Photo) {
        store?.fetchImage(for: photo, completion: { (ImageResult) -> Void in
            switch ImageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image \(error)")
            }
        })
    }
}
