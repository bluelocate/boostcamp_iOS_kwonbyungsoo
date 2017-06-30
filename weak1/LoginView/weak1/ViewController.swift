//
//  ViewController.swift
//  weak1
//
//  Created by byung-soo kwon on 2017. 6. 30..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var id:String?
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    //MARK: TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == idTextField{
            
            id = textField.text
            
        }else if textField == passwordTextField{
          
            password = textField.text
        
        }else {
            id = "no"
            password = "no"
        }
        
    }
    
    //MARK: Button Action
    @IBAction func signUpAction(_ sender: UIButton) {
        print("touch up inside - sign up")
    }

    @IBAction func signInAction(_ sender: UIButton) {
        print("ID : \(id!), PW : \(password!)")
    }
    
    
}

