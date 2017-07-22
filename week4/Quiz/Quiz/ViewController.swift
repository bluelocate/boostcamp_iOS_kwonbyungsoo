//
//  ViewController.swift
//  Quiz
//
//  Created by byung-soo kwon on 2017. 6. 29..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    //모델
    let questions: [String] = ["From what is cognac made?", "What is 7+7?", "What is the capital of Vermont"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    
    
    //컨트롤러
    var currentQuestionIndex: Int = 0
    
    //뷰
    @IBAction func showNextQuestion(_ sender: AnyObject){
        
        currentQuestionIndex = (currentQuestionIndex + 1) % questions.count
        
        let question: String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(_ sender: AnyObject){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }
}

