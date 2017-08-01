//
//  AddArticleViewController.swift
//  PictureBoard
//
//  Created by byung-soo kwon on 2017. 7. 31..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class AddArticleViewController: UIViewController {
    
    let connectAPI = ConnectAPI()
    
    @IBOutlet var titleLabel: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        
        
        addArticle(title: "5인큐짱", desc: "부스트캠프 화이팅")
    }
    
    func addArticle(title: String, desc: String) {
        
        let body = ["image_title" : "오늘 저녁은 치킨이닭!! ","image_desc": "아직 지우는걸 구현 못했어요 죄송.."]
        guard let url = URL(string: "\(urlList.addArticle)") else {
            return
        }
        connectAPI.addArticleRequest(url: url,
                                     body: body as [String : String],
                                     httpMethod: "POST")
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
