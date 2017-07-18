//
//  LoginViewController.swift
//  Login
//
//  Created by byung-soo kwon on 2017. 7. 9..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore



class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var myButton: AnotherMyButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var user = AccessToken.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 100, width: 180, height: 40)
        myLoginButton.setTitle("My Login Button", for: .normal)
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        view.addSubview(myLoginButton)
        
        let myLogoutButton = UIButton(type: .custom)
        myLogoutButton.backgroundColor = UIColor.gray
        myLogoutButton.frame = CGRect(x: 50, y: 50, width: 180, height: 40)
        myLogoutButton.setTitle("My LogOut Button", for: .normal)
        myLogoutButton.addTarget(self, action: #selector(self.logoutButtonClicked), for: .touchUpInside)
        view.addSubview(myLogoutButton)
        
        if let token = AccessToken.current{
            print("profile: \(token)!")
        }
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.fetchProfile()
                print("Logged in!")
            }
        }
    }
    
    func fetchProfile() {
        
        let params = ["fields" : "email, name"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    
                    if let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController"){
                        self.present(signupViewController, animated: true, completion: nil)
                    }
                    UserInfo.userInfo.append( UserInfo(firstName: responseDictionary["name"] as? String,
                                              lastName: responseDictionary["email"] as? String))
                }
            }
        }
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print(" 결과 : \(result)")
    }
    
    func logoutButtonClicked(){
        print(#function)
        let loginManager = LoginManager()
        loginManager.logOut()
    }
}

