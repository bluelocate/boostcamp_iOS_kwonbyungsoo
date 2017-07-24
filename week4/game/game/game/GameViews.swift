//
//  GameViews.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

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
        for i in 0 ... 4 {
            for j in 0 ... 4 {
                let gameButton = UIButton()
                gameButton.setTitle("4", for: .normal)
                gameButton.setTitle("5", for: .highlighted)
                gameButton.isUserInteractionEnabled = true
                gameButton.backgroundColor = UIColor.gray
                gameButton.frame = CGRect(x: CGFloat(i) * self.width + 5,
                                          y: CGFloat(j) * self.height,
                                          width: self.width-10,
                                          height: self.height-10)
                temporaryBoard.append(gameButton)
            }
        }
        print("\(temporaryBoard.count)")
        boardButtons = temporaryBoard
    }
}
