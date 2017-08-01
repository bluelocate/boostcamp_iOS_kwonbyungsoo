//
//  AddArticleViewController.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class AddArticleViewController: UIViewController {

    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bodyTextView: UITextView!
    
    let connectAPI = ConnectAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        
        guard let titleText = titleLabel.text,
            let descText = bodyTextView.text else { return }
        if titleText.isEmpty {
            let alertController = UIAlertController(title: "타이틀이 없습니다.", message: "",
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK",
                                            style: .default,
                                            handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        addArticle(title: titleText, desc: descText)
    }
    
    func addArticle(title: String, desc: String) {
        
        let body = ["image_title" : title,"image_desc": desc]
        guard let url = URL(string: "\(urlList.addArticle)") else { return }
        guard let image = imageView.image else { return }
        imageView.image?.accessibilityIdentifier = "myImage.jpg"
        connectAPI.addArticleRequest(url: url,
                                     body: body as [String : String],
                                     httpMethod: "POST",
                                     image: image,
                                     imageTitle: "myImage.jpg")
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddArticleViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickGesture(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

}

extension AddArticleViewController:  UITextFieldDelegate, UITextViewDelegate {
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
