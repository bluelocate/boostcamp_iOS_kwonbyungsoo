//
//  ViewController.swift
//  FoodTracker
//
//  Created by byung-soo kwon on 2017. 6. 30..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Handle text field's user input through delegate callbacks.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{

        //hide the keyboard
        textField.resignFirstResponder()
        return true
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
    
        mealNameLabel.text = textField.text
        
    }
    
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
        
    }
    

}

