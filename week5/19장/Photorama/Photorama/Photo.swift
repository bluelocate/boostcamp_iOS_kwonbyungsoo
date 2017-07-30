//
//  Photo.swift
//  Photorama
//
//  Created by byung-soo kwon on 2017. 7. 29..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import Foundation

// 웹 서비스에서 반환된 각 사진 정보.
class Photo {
    
    private let title: String
    private let photoID: String
    private let dateTaken: Date
    let remoteURL: URL
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}
