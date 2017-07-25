//
//  GameViews.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import GameplayKit
struct GameViews {
    
    let superView: UIView
    let width: CGFloat
    let height: CGFloat
    // 버튼 초기화하자
    var boardButtons: [UIButton] = []
    
    init(superView: UIView, width: CGFloat, height: CGFloat) {
        self.superView = superView
        self.width = width / 5
        self.height = height / 5
        var temporaryBoard: [UIButton] = []
        print("view is created")
        
        let numberSet = [Int](1...25)
        guard let shuffleNumber = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numberSet) as? [Int] else {
            return
        }
        
        var index = 0
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                let gameButton = UIButton()
                gameButton.isUserInteractionEnabled = true
                gameButton.backgroundColor = UIColor.gray
                gameButton.frame = CGRect(x: CGFloat(i) * self.width + 5,
                                          y: CGFloat(j) * self.height,
                                          width: self.width-10,
                                          height: self.height-10)
                gameButton.setTitle("\(shuffleNumber[index])", for: .normal)
                gameButton.setTitleColor(UIColor.black, for: .highlighted)
                
                temporaryBoard.append(gameButton)
                index += 1
            }
        }
        print("\(temporaryBoard.count)")
        boardButtons = temporaryBoard
    }
}
