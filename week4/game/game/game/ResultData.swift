//
//  ResultData.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import Foundation

struct ResultData {
    var name: String
    var time: String
    var dateCreated: String
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    init(name: String, time: String) {
        self.name = name
        self.time = time
        self.dateCreated = dateFormatter.string(from: Date())
        
    }
}
