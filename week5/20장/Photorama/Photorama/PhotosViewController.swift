//
//  PhotosViewController.swift
//  Photorama
//
//  Created by byung-soo kwon on 2017. 7. 29..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore?
    let photoDataSource = PhotoDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        store?.fetchRecentPhotos {
            (PhotosResult) -> Void in
            switch PhotosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching recent photos \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        store?.fetchImage(for: photo, completion: { (result) -> Void in
            guard let photoIndex = self.photoDataSource.photos.index(of: photo) else {
                return
            }
            guard case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
            
        })
    }
}
