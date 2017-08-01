//
//  connectAPI.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit


struct urlList {
    static let baseURL = "https://ios-api.boostcamp.connect.or.kr"
    static let login = "https://ios-api.boostcamp.connect.or.kr/login"
    static let signUp = "https://ios-api.boostcamp.connect.or.kr/user"
    static let addArticle = "https://ios-api.boostcamp.connect.or.kr/image"
}
struct ConnectAPI {
    
    var userID: String?
    var userPassword: String?
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
                    guard let jsons = json as? [[String : Any]],
                        let result = self.getArticleInformation(fromJSON: jsons) else { return }
                    OperationQueue.main.addOperation {
                        completion(result)
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
                let imageURL = json[index]["thumb_image_url"] as? String,
                let imageDesc = json[index]["image_desc"] as? String,
                let authorNickName = json[index]["author_nickname"] as? String,
                let createdDate = json[index]["created_at"] as? Int else { return nil }
            self.fetchImage(url: imageURL, completion: {
                (UIImage) in
                print("이미지 다 받았니?")
                sharedImageInfo.imageArray.append(UIImage) })
            guard let url = URL(string: imageURL) else { return nil }
            sharedImageInfo.imageBoardInfo.append(ImageBoardInfo(imageURL: url,
                                                                 title: imageTitle,
                                                                 description: imageDesc,
                                                                 nickName: authorNickName,
                                                                 createdDate: createdDate))
        }
        return sharedImageInfo.imageBoardInfo
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage) -> Void) {
        
        guard let photoURL = URL(string: "\(urlList.baseURL)\(url)") else { return }
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                OperationQueue.main.addOperation {
                    completion(image)
                }
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
                            guard let httpStatus = response as? HTTPURLResponse else{ return }
                            print("status code should be code : \(httpStatus.statusCode)")
                            
                            guard
                                let jsons = json as? [String : Any],
                                let result = self.authUser(fromJSON: jsons,
                                                           statusCode: httpStatus.statusCode) else { return }
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
    
    func authUser(fromJSON json: [String : Any], statusCode: Int) -> SignUpInfo? {
        guard
            let id = json["email"] as? String,
            let password = json["password"] as? String else {
                return SignUpInfo(id: "", password: "", statusCode: statusCode)
        }
        return SignUpInfo(id: id, password: password, statusCode: statusCode)
    }
    
    func addArticleRequest(url: URL,
                           body: [String : Any],
                           httpMethod: String,
                           image: UIImage,
                           imageTitle: String) {
        
        var request = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        request.httpBody = createBody(parameters: body,
                                      boundary: boundary,
                                      data: imageData,
                                      mimeType: "image/jpg",
                                      filename: "\(imageTitle)")
        let session = URLSession.shared
        let task = session.dataTask(with: request,
                                    completionHandler:
            {
                (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        guard let httpStatus = response as? HTTPURLResponse else { return }
                        print("status code should be code : \(httpStatus.statusCode)")
                    } catch {
                        print(error)
                    }
                }
        })
        task.resume()
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
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let data = data {
            append(data)
        }
    }
}
