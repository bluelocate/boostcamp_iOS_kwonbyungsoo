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
                           httpMethod: String) {
        
        var request = URLRequest(url: url)

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        

        do {
            request.httpBody = createBody(parameters: body, boundary: boundary, data: UIImageJPEGRepresentation(#imageLiteral(resourceName: "chicken.jpg"), 0.7)!, mimeType: "image/jpg", filename: "chicken.jpg")
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
    
    func createBody(parameters: [String:Any],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"image_data\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
        
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

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
