//
//  InfoManager.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 30..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

let sharedInfo = InfoManager.shared
class InfoManager {
    
    static let shared = InfoManager()
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    var info: [SignUpInfo] = []
    
    func requestAllInfo(url: URL) {
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }
}
