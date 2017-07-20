//
//  Item.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 14..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit


class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork", "Mac"]
        var idx = arc4random_uniform(UInt32(adjectives.count))
        let randomAdjective = adjectives[Int(idx)]
        idx = arc4random_uniform(UInt32(nouns.count))
        let randomNoun = nouns[Int(idx)]
        let randomName = "\(randomAdjective) \(randomNoun)"
        let randomValue = Int(arc4random_uniform(100))
        let randomsSerialNumber = NSUUID().uuidString.components(separatedBy: "-").first!
        
        if random {
            self.init(name: randomName,
                      serialNumber: randomsSerialNumber,
                      valueInDollars: randomValue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
}
