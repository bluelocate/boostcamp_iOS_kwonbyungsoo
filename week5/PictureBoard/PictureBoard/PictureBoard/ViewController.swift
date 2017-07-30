//
//  ViewController.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 30..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: UIButton) {
        guard let idText = idTextField.text else {
            return
        }
        guard let passwordText = passwordTextField.text else {
            return
        }
        
        if idText.isEmpty || passwordText.isEmpty {
            alertAction(title: "", message: "모든 항목을 입력하세요.")
        }
        
        for item in sharedInfo.info {
            if idText == item.id && passwordText == item.password {
                guard let imageBoardViewController = storyboard?.instantiateViewController(withIdentifier: "imageViewController") as? ImageBoardViewController else {
                    return
                }
                show(imageBoardViewController, sender: self)
                break
            } else {
                alertAction(title: "", message: "아이디 혹은 비밀번호가 다릅니다.")
                break
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func alertAction(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

