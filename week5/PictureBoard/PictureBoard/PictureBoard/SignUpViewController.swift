//
//  SignUpViewController.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 30..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var passwordCheckTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    
    let connectAPI = ConnectAPI()
    
    @IBAction func signUpAction(_ sender: UIButton) {
        guard let idText = idTextField.text else {
            return
        }
        guard let nicknameText = nicknameTextField.text else {
            return
        }
        guard let passwordText = passwordTextField.text else {
            return
        }
        guard let passwordChek = passwordCheckTextField.text else {
            return
        }
        if idText.isEmpty || nicknameText.isEmpty || passwordText.isEmpty || passwordChek.isEmpty {
            alertAction(title: "", message: "모든 항목을 입력해 주세요,")
        }
        
        if idText.contains("@") {
            if !(passwordTextField.text == passwordCheckTextField.text) {
                alertAction(title: "Not same password", message: "please check")
            } else {
                sharedInfo.info.append(SignUpInfo(id: idText,
                                                 nickname: nicknameText,
                                                 password: passwordText))
                alertAction(title: "", message: "가입되었습니다!")
                connectAPI.newUser(email: idText, password: passwordText, nickName: nicknameText)
            }
        } else {
            alertAction(title: "no '@'", message: "It's error")
        }
    }
    
    func alertAction(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

