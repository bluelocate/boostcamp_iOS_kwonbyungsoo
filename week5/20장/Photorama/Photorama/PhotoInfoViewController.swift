//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by byung-soo kwon on 2017. 7. 30..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo? {
        didSet {
            navigationItem.title = photo?.title
        }
    }
    var store: PhotoStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = self.photo else {
            return
        }
        store?.fetchImage(for: photo, completion: { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        })
    }
}
