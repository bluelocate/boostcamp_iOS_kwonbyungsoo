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
    
    
    var farenheitValue: Double?{
        didSet{
            updateCelsiusLabel()
        }
    }

    var celsiusValue: Double?{
    
        if let value = farenheitValue{
            return (value - 32) * (5/9)
    
        } else {
            return nil
        }
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
        }else {
            print("입력해")
            return true
        }
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
