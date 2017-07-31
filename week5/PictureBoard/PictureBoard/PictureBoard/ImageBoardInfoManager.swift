//
//  ImageBoardInfoManager.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

let sharedImageInfo = ImageBoardInfoManager.sharedImageBoardInfo
class ImageBoardInfoManager {
    static let sharedImageBoardInfo = ImageBoardInfoManager()
    var imageBoardInfo: [ImageBoardInfo] = []
    var imageArray: [UIImage] = []
    
}
