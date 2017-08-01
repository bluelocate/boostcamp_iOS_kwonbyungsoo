//
//  ImageBoardViewController.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class ImageBoardViewController: UIViewController {
    let connectAPI = ConnectAPI()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImageBoardViewController: UITableViewDelegate {
    
}

extension ImageBoardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count : \(sharedImageInfo.imageBoardInfo.count)")
        return sharedImageInfo.imageBoardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell", for: indexPath) as?ImageBoardViewCell else {
            return UITableViewCell()
        }
        let info = sharedImageInfo.imageBoardInfo[indexPath.row]
        cell.titleLabel.text = info.title
        cell.descLabel.text = info.description
        cell.createdDate.text = String(describing: info.createdDate)
        cell.imageView?.image = sharedImageInfo.imageArray[indexPath.row]
        cell.imageView?.sizeThatFits(CGSize(width: 60, height: 60))
        return cell
    }
}
