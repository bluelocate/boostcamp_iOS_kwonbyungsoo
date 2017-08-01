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
        self.imageView.image = UIImage(data: UIImageJPEGRepresentation(#imageLiteral(resourceName: "samples.png"), 0.9)!)
        
    }
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "samples.png"))?.base64EncodedString()
        
    
        
        addArticle(title: "5인큐짱", desc: "부스트캠프 화이팅", image: imageData!)
    }
    
    
    func addArticle(title: String, desc: String, image: String) {
        
        let body = ["image_title" : "오늘 저녁은 치킨이닭!! ","image_desc": "아직 지우는걸 구현 못했어요 죄송.."]
        
        connectAPI.addArticleRequest(
            url: URL(string:"https://ios-api.boostcamp.connect.or.kr/image")!,
            body: body as [String : String],
            httpMethod: "POST")
    }
}
