//
//  connectAPI.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

enum Method: String {
    case login = "login"
    case user = "user"
    case articleList = "image"
    case article = "image/:article_id:"
}

enum StatusCode: Int {
    case ok = 200
    case success = 201
}

struct ConnectAPI {
    
    static let baseURLString = "https://ios-api.boostcamp.connect.or.kr"
    var userID: String?
    var userPassword: String?
    var allURL:URL = {
        return URL(string: baseURLString)!
    }()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func getArticle(url: URL, completion: @escaping ([ImageBoardInfo]) -> Void) {
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(json)
                    let result = self.getArticleInformation(fromJSON: json as! [[String : Any]])
                    OperationQueue.main.addOperation {
                        completion(result!)
                    }
                } catch {
                    print("error json")
                }
            }
        }
        task.resume()
    }
    
    func getArticleInformation(fromJSON json: [[String:Any]]) -> [ImageBoardInfo]? {
        
        for (index, _) in json.enumerated(){
            guard
                let imageTitle = json[index]["image_title"] as? String,
                let imageURL = json[index]["image_url"] as? String,
                let imageDesc = json[index]["image_desc"] as? String,
                let authorNickName = json[index]["author_nickname"] as? String,
                let createdDate = json[index]["created_at"] as? Int else {
                    sharedImageInfo.imageBoardInfo.append(ImageBoardInfo(imageURL: URL(string: "")!,
                                                                         title: "",
                                                                         description: "",
                                                                         nickName: "",
                                                                         createdDate: 0))
                    continue
            }
            self.fetchImage(url: imageURL, completion: { (UIImage) in
                sharedImageInfo.imageArray.append(UIImage)
            })
            sharedImageInfo.imageBoardInfo.append(ImageBoardInfo(imageURL: URL(string: imageURL)!,
                                                                 title: imageTitle,
                                                                 description: imageDesc,
                                                                 nickName: authorNickName,
                                                                 createdDate: createdDate))
        }
        return sharedImageInfo.imageBoardInfo
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage) -> Void) {
        let photoURL = URL(string: "\(allURL)\(url)")
        let request = URLRequest(url: photoURL!)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            let image = UIImage(data: data!)
            OperationQueue.main.addOperation {
                completion(image!)
            }
        }
        task.resume()
    }
    
    func newUser(email: String, password: String, nickName: String) {
        let body = ["email" : email, "password" : password, "nickname" : nickName]
        makeNewRequest(url: URL(string:"https://ios-api.boostcamp.connect.or.kr/user")!,
                       body: body as [String : AnyObject],
                       httpMethod: "POST",
                       completion: {
                        signUpInfo in
                        return
        })
    }
    
    func makeNewRequest(url: URL,
                        body: [String : Any],
                        httpMethod: String,
                        completion: @escaping (SignUpInfo) -> Void) {
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonBody
            let session = URLSession.shared
            let task = session.dataTask(with: request,
                                        completionHandler:
                {
                    (data, response, error) in
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                            guard let httpStatus = response as? HTTPURLResponse else{
                                return
                            }
                            print("status code should be code : \(httpStatus.statusCode)")
                            guard let result = self.authUser(fromJSON: json as! [String : Any],
                                                             statusCode: httpStatus.statusCode)
                                else {
                                    completion(self.authUser(fromJSON: json as! [String : Any],
                                                             statusCode: httpStatus.statusCode)!)
                                    return
                            }
                            OperationQueue.main.addOperation {
                                completion(result)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
            })
            task.resume()
        } catch {
            print("something going to wrong!")
        }
    }
    
    func addArticleRequest(url: URL,
                        body: [String : Any],
                        httpMethod: String,
                        completion: @escaping (ImageBoardInfo) -> Void) {
        
        var request = URLRequest(url: url)
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonBody
            let session = URLSession.shared
            let task = session.dataTask(with: request,
                                        completionHandler:
                {
                    (data, response, error) in
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                            guard let httpStatus = response as? HTTPURLResponse else{
                                return
                            }
                            print("status code should be code : \(httpStatus.statusCode)")
                            let result = self.addArticle()
                            OperationQueue.main.addOperation {
                                completion(result!)
                            }
                        } catch {
                            print(error)
                        }
                    }
            })
            task.resume()
        } catch {
            print("something going to wrong!")
        }
    }
    
    func addArticle() -> ImageBoardInfo? {
        
        return  ImageBoardInfo(imageURL: URL(string: "")!, title: "", description: "", nickName: "", createdDate: 0)
    }
    
    func authUser(fromJSON json: [String : Any], statusCode: Int) -> SignUpInfo? {
        guard
            let id = json["email"] as? String,
            let password = json["password"] as? String else {
                return SignUpInfo(id: "", password: "", statusCode: statusCode)
        }
        return SignUpInfo(id: id, password: password, statusCode: statusCode)
    }
}
