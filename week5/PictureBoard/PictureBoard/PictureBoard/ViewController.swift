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
    let connectAPI = ConnectAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedInfo.requestAllInfo(url: connectAPI.allURL)
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
            return
        }
        login(email: idText, password: passwordText)
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
    
    
    func login(email: String, password: String) {
        let body = ["email" : email, "password" : password]
        connectAPI.makeNewRequest(
            url: URL(string:"https://ios-api.boostcamp.connect.or.kr/login")!,
            body: body as [String : Any],
            httpMethod: "POST",
            completion:
            {
                (SignUpInfo) -> Void in
                if SignUpInfo.id == email && SignUpInfo.password == password {
                    print("정보가 같습니다.")
                    print("\(SignUpInfo.statusCode)")
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "imageTabViewController")
                    self.present(viewController!, animated: true, completion: nil)
                }
                if SignUpInfo.statusCode == 401 {
                    print("비밀번호 혹은 아이디가 다릅니다.")
                    self.alertAction(title: "", message: "비밀번호 혹은 아이디가 다릅니다.")
                }
        })
    }
}

