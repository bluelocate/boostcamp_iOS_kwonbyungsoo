//
//  SignUpInfo.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 30..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class SignUpInfo {
    
  
    var id: String
    var nickname: String
    var password: String
    
    init(id: String, nickname: String, password: String) {
        self.id = id
        self.nickname = nickname
        self.password = password
    }
    
    init(id:String, password: String) {
        self.id = id
        self.password = password
        self.nickname = ""
    }
   }
