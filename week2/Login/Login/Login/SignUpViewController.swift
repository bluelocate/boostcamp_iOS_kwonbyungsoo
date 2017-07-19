//
//  ViewController.swift
//  Login
//
//  Created by byung-soo kwon on 2017. 7. 9..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    
    @IBOutlet weak var sampleTextView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    var name: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view 생성!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.text = name
        idTextField.delegate = self
        passwordTextField.delegate = self
        verifyPasswordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        // 순차적으로 입력이 끝나면 내려갈 수 있도록
        if textField == idTextField{
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField{
            verifyPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: UIImage Picker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: 액션
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //이미지 선택시 텍스트 필드 키보드 내려가기
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        verifyPasswordTextField.resignFirstResponder()
        sampleTextView.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: 뷰 터치시 텍스트 뷰의 키보드 내리기
    @IBAction func hideKeyboardTouchView(_ sender: UITapGestureRecognizer) {
        sampleTextView.resignFirstResponder()
    }
    
    //중간 도전 과제 Cancel 시 모달 dismiss(도전과제)
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //중간 도전 과제 Sign Up 시 모달 dismiss(도전과제)
    @IBAction func signUpButton(_ sender: UIButton) {
        //만약 패스워드가 일치하지 않는다면 모달을 내리지 않는다. (도전과제) 이거 if문 뭔가 복잡합니다..
        if (passwordTextField.text != verifyPasswordTextField.text) ||
            ((passwordTextField.text?.isEmpty)! && (verifyPasswordTextField.text?.isEmpty)!){
            print("Not Matching Password! with password \(passwordTextField.text!) and verify \(verifyPasswordTextField.text!)")
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: 선택된 이미지를 셋팅합니다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //수정된 사진파일이 사용될 수 있도록 한다.
        guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("There is no image")
            return
        }
        profileImage.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: 텍스트뷰에 에디팅이 시작되면
    func textViewDidBeginEditing(_ textView: UITextView){
        let textView = UITextView()
        textView.delegate = self
    }
}

