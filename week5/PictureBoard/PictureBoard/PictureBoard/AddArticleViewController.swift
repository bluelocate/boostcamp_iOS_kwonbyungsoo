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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let url = URL(string: "\(urlList.baseURL)") else {
            return
        }
        connectAPI.getArticle(url: url, completion: {
            (ImageBoardInfo) -> Void in
            print(ImageBoardInfo)
        })
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
        
        let body = ["image_title" : "오늘 저녁은 치킨이닭!! ","image_desc": "아직 지우는걸 구현 못했어요 죄송.."]
        guard let url = URL(string: "\(urlList.addArticle)") else { return }
        guard let image = imageView.image else { return }
        imageView.image?.accessibilityIdentifier = "myImage.jpg"
        connectAPI.addArticleRequest(url: url,
                                     body: body as [String : String],
                                     httpMethod: "POST",
                                     image: image,
                                     imageTitle: imageView.image?.accessibilityIdentifier ?? "")
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
