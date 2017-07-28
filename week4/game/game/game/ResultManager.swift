//
//  ResultManager.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import Foundation

var manager = ResultManager.resultManager

struct ResultManager {
    static var resultManager = ResultManager()
    var history: [ResultData] = []
    var arrangedResult: [ResultData] = []
    let itemArchiveURL: NSURL = {
       let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive") as NSURL
    }()
    
    func saveChanged() {
        print("Saving items to : \(itemArchiveURL.path!)")
        print(manager.history)
        NSKeyedArchiver.archiveRootObject(manager.history, toFile: itemArchiveURL.path!)
    }
}
