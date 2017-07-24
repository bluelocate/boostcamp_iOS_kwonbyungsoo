//
//  GameViewController.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gameViews = GameViews(superView: gameView,
                                  width: gameView.frame.width,
                                  height: gameView.frame.height)
        
        for item in gameViews.boardButtons {
            print("viewadd")
            gameView.addSubview(item)
        }
    }
}

