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
    init() {
    }
}
