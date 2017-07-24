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
    var gameViews: GameViews!
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        gameViews = GameViews(superView: gameView,
                              width: gameView.frame.width,
                              height: gameView.frame.height)
        gameStart(button: gameViews.boardButtons)
    }
    
    func gameStart(button: [UIButton]) {
       

        for (index, item) in button.enumerated() {
            print(index)
            item.addTarget(self, action: #selector(checkNumber(button:)), for: .touchUpInside)
            gameView.addSubview(item)
        }
    }
    
    func checkNumber(button: UIButton) {
        
        guard let number: String = button.titleLabel?.text else {
            return
        }
        guard let numberFromString = Int(number) else {
            return
        }
        if count == numberFromString {
            print("정답")
            button.isHidden = true
            count += 1
        }
    }
}

