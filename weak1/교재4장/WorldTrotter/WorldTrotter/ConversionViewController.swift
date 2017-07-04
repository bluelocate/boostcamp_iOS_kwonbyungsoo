//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by byung-soo kwon on 2017. 7. 3..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit


class ConversionViewController: UIViewController{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!

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
    
    func updateCelsiusLabel() {
    
        if let value = celsiusValue{
            celsiusLabel.text = "\(value)"
        }else {
            celsiusLabel.text = "???"
        }
        
    }
    
    @IBAction func dismissKeyBoard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
}
