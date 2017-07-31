//
//  ImageBoardInfo.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class ImageBoardInfo {
    var imageURL: URL
    var title: String
    var description: String?
    var nickName: String
    var createdDate: Int
    init(imageURL: URL, title: String, description: String, nickName: String, createdDate: Int) {
        self.imageURL = imageURL
        self.title = title
        self.description = description
        self.nickName = nickName
        self.createdDate = createdDate
    }
}
