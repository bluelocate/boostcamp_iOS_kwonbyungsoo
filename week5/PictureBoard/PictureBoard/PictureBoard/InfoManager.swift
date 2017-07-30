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
    
    func requestAllInfo() {
        let url = ConnectAPI.allURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }

    
    func requestSignUpInfo() {
        let url = ConnectAPI.loginURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }
    
    func requestUserInfo() {
        let url = ConnectAPI.userURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }
    
    func requestArticleListInfo() {
        let url = ConnectAPI.articleListURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }
    
    func requestArticleInfo() {
        let url = ConnectAPI.articleURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        task.resume()
    }


}
