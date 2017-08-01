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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell", for: indexPath) as!ImageBoardViewCell
        let info = sharedImageInfo.imageBoardInfo[indexPath.row]
        print(sharedImageInfo.imageBoardInfo[indexPath.row].title)
        cell.titleLabel.text = info.title
        cell.descLabel.text = info.description
        cell.createdDate.text = String(describing: info.createdDate)
        cell.imageView?.image = sharedImageInfo.imageArray[indexPath.row]
        cell.imageView?.sizeToFit()
        return cell
    }
}
