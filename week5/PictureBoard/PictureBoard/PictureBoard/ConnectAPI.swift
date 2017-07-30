//
//  connectAPI.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import Foundation

enum Method: String {
    case login = "login"
    case user = "user"
    case articleList = "image"
    case article = "image/:article_id:"
}

struct ConnectAPI {
    
    var userID: String?
    var userPassword: String?
    
    static let baseURLString = "https://ios-api.boostcamp.connect.or.kr/"
    
    static func allURL() -> URL {
        return URL(string: baseURLString)!
    }
    static func loginURL() -> URL {
        return URL(string: "\(baseURLString)\(Method.login)")!
    }
    static func userURL() -> URL {
        return URL(string: "\(baseURLString)\(Method.user)")!
    }
    static func articleListURL() -> URL {
        return URL(string: "\(baseURLString)\(Method.articleList)")!
    }
    static func articleURL() -> URL {
        return URL(string: "\(baseURLString)\(Method.article)")!
    }
    
    
    func newUser(email: String, password: String, nickName: String) {
        let body = ["email" : email, "password" : password, "nickname" : nickName]
        makeNewRequest(url: URL(string:"https://ios-api.boostcamp.connect.or.kr/user")!, body: body as [String : AnyObject], httpMethod: "POST", completion: {
            signUpInfo in
            return
        })
    }
    
    
    func makeNewRequest(url: URL, body: [String : Any], httpMethod: String, completion: @escaping (SignUpInfo) -> Void) {
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
                            
                            guard let result = self.authUser(fromJSON: json as! [String : Any]) else {
                                return
                            }
                            completion(result)
                        } catch {
                            print(error)
                        }
                    }
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {
                        print("status code should be code : \(httpStatus.statusCode)")
                    }
            })
            task.resume()
        } catch {
            print("something going to wrong!")
        }
    }
    
    func authUser(fromJSON json: [String : Any]) -> SignUpInfo? {
        guard
            let id = json["email"] as? String,
            let password = json["password"] as? String else {
                return nil
        }
        return SignUpInfo(id: id, password: password)
    }
    
}
