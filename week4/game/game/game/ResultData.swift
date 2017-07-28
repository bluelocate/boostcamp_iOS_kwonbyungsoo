//
//  ResultData.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import Foundation

class ResultData: NSObject, NSCoding {
    var name: String
    var time: String
    var dateCreated: String
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(dateCreated, forKey: "dateCreated")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        time = aDecoder.decodeObject(forKey: "time") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! String
        super.init()
    }
    
    init(name: String, time: String) {
        self.name = name
        self.time = time
        self.dateCreated = dateFormatter.string(from: Date())
        
    }
}
