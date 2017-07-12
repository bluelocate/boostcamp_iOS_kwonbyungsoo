//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by byung-soo kwon on 2017. 7. 3..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit


class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    
    let numberFormatter: NumberFormatter = {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        numberFormat.minimumFractionDigits = 0
        numberFormat.maximumFractionDigits = 1
        return numberFormat
    }()
    
    //MARK: 현재 밤인지 판단하는 프로퍼티
    var isNight: Bool{
     
        let date = Date()
        let currentTime = Calendar.current
        let hour = currentTime.component(.hour, from: date)
        let minute = currentTime.component(.minute, from: date)
        print("지금 시간은 :\(hour)시 \(minute)분")
        if hour > 18{ return true }

        return false
        
    }
    
    //MARK: 초기 뷰 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its View")
    }
    
    
    //MARK: 시간대에 따라서 배경색 갱신
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isNight{
            print("밤이다")
            view.backgroundColor = UIColor.lightGray
        }else {
            print("낮이다")
            view.backgroundColor = UIColor.white
        }
        
    }
    
    
    
    var farenheitValue: Double?{
        didSet{
            updateCelsiusLabel()
        }
    }

    var celsiusValue: Double?{
    
        if let value = farenheitValue{
            return (value - 32) * (5/9)
    
        }
        return nil
        
    }
    
    @IBAction func farenheitFieldEditingChanged(textField: UITextField){
        
        if let text = textField.text, let value = Double(text){
            farenheitValue = value
        }else {
            farenheitValue = nil
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeperator = string.range(of: ".")
        
        //MARK: 동메달 과제 추가부분
        let replacementTextHasCharacterValue = string.rangeOfCharacter(from: .letters)
        let existingTextHasCharacter = textField.text?.rangeOfCharacter(from: .letters)
        
        if existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil || (replacementTextHasCharacterValue != nil || existingTextHasCharacter != nil){
            print("입력하지마")
            return false
        }
        return true
    }
    
    func updateCelsiusLabel() {
    
        if let value = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from:  value as NSNumber)
        }else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    
    @IBAction func dismissKeyBoard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    
    
}
