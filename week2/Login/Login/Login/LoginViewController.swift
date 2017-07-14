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
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: 커스텀 필요없음. 페북이 만든거 가져다가 쓰면 됨.
        let myLoginButton = LoginButton(readPermissions: [.publicProfile,.email])
        myLoginButton.frame = CGRect(x: view.center.x, y: view.center.y, width: 180, height: 40)
        // Handle clicks on the button
        myLoginButton.delegate = self
        // Add the button to the view
        view.addSubview(myLoginButton)

        //MARK: 로그인 버튼을 커스텀으로 하는 경우 필요.
        
//        let myLoginButton = UIButton(type: .custom)
//        myLoginButton.backgroundColor = UIColor.darkGray
//        myLoginButton.frame = CGRect(x: view.center.x, y: view.center.y, width: 180, height: 40)
//        myLoginButton.setTitle("My Login Button", for: .normal)
//        // Handle clicks on the button
//        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
//        
//        // Add the button to the view
//        view.addSubview(myLoginButton)
        
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
    
    // 버튼을 커스터마이징 했을 때 버튼 액션 함수 -> 이때는 로그인 매니저로 일일이 확인해주어야 함.
//    @objc func loginButtonClicked() {
//        
//        let loginManager = LoginManager()
//        
//        loginManager.logIn([ .publicProfile, .email], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                
//                self.fetchProfile()
//                print("Logged in!")
//            }
//        }
//    }
    
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
                    userInfo.append( UserInfo(firstName: responseDictionary["name"] as? String,
                                              lastName: responseDictionary["email"] as? String))
                  
                    //데이터를 받았으면 signUpViewController 로 이동
                    if let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signUpViewController"){
                        self.present(signupViewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    //로그인버튼 델리게이트를 사용하면 로그인 매니저따위 필요 없음 그냥 정보 받아오면 되는것이었다!
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print(result)
        print("로그인 했다!")
        self.fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        print("로그아웃 했다!")
    }
    
    func logoutButtonClicked(){
        print(#function)
        let loginManager = LoginManager()
        loginManager.logOut()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    
}

