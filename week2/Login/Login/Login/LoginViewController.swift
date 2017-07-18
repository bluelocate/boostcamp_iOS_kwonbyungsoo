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

var userInfo:[UserInfo] = []
var user = AccessToken.current

class LoginViewController: UIViewController,UITextFieldDelegate,LoginButtonDelegate {
    
    
    @IBOutlet weak var myButton: AnotherMyButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 100, width: 180, height: 40)
        myLoginButton.setTitle("My Login Button", for: .normal)
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        //MARK: 로그아웃 버튼 추가
        let myLogoutButton = UIButton(type: .custom)
        myLogoutButton.backgroundColor = UIColor.gray
        myLogoutButton.frame = CGRect(x: 50, y: 50, width: 180, height: 40)
        myLogoutButton.setTitle("My LogOut Button", for: .normal)
        
        // Handle clicks on the button
        myLogoutButton.addTarget(self, action: #selector(self.logoutButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
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
                
                //이 부분을 다른곳에....
                if let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController"){
                    
                    self.present(signupViewController, animated: true, completion: nil)
                }
                print("Logged in!")
            }
        }
    }
    
    
    func fetchProfile(){
        
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
                    print(responseDictionary)
                    print(responseDictionary["name"] ?? "")
                    print(responseDictionary["email"] ?? "")
                    userInfo.append( UserInfo(firstName: responseDictionary["name"] as? String, lastName: responseDictionary["email"] as? String))
                    
                }
            }
        }
    

    }


    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        print(" 결과 : \(result)")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        
    }
    
    func logoutButtonClicked(){
        print(#function)
        let loginManager = LoginManager()
        loginManager.logOut()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    
}

