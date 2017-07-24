//
//  GameViewController.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var clearTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var gameView: UIView!
    var gameViews: GameViews!
    var resultData: ResultData!
    var resultManager = ResultManager()
    var count = 1
    var timer:Timer?
    var startTime: Double = 0
    var resultTime = Date()
    var name: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func gameTimer(timer: Timer) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "mm:ss:SS"
        
        let referenceDate = Date(timeIntervalSince1970: 0)
        resultTime = referenceDate + Date().timeIntervalSinceReferenceDate - startTime
        self.timeLabel.text = dateFormat.string(from: resultTime)
    }
    
    func gameStart(button: [UIButton]) {
        for item in button {
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
        
        if count == 2 {
            count = 1
            timer?.invalidate()
            self.timer = nil
            startButton.isHidden = false
            gameView.bringSubview(toFront: startButton)

            endGame()
            
        }
    }
    
    func endGame() {
        print("game over!")

        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "mm:ss:SS"
        let stringTime = dateFormat.string(from: self.resultTime)
        print(stringTime)
        self.timer?.invalidate()
        self.timer = nil
        
        let alertController = UIAlertController(title: "Clear!", message: "Congratuations!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.name = alertController.textFields?[0].text
            let result = ResultData(name: self.name!, time: stringTime)
            self.resultManager.history.append(result)
            let bestData = self.bestScore(resultData: self.resultManager.history)
            self.nameLabel.text = bestData.name
            self.clearTimeLabel.text = bestData.time
        })
        alertController.addAction(okAction)
        alertController.addTextField { UITextField in
            UITextField.placeholder = "이름을 입력해 주세요."
        }
        present(alertController, animated: true, completion: nil)
       
    }
    
    func bestScore(resultData: [ResultData]) -> ResultData {
        print("best Score")
        let arrangedData = resultData.sorted(by: {$0.time < $1.time})
        resultManager.arrangedResult = arrangedData
        return arrangedData[0]
        
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        startButton.isHidden = true
        print("게임 시작!")
        gameViews = GameViews(superView: gameView,
                              width: gameView.frame.width,
                              height: gameView.frame.height)
        gameStart(button: gameViews.boardButtons)

        self.timer?.invalidate()
        self.timer = nil
        startTime = Date().timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(gameTimer(timer:)), userInfo: nil, repeats: true)
        self.timer?.fire()
    }
}

