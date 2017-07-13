//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by byung-soo kwon on 2017. 7. 4..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import WebKit

class WebViewController:UIViewController{
    
    
    var webView: WKWebView!
    
    override func loadView() {
    
        //웹 뷰 생성
        webView = WKWebView()
        
        //웹 뷰를 이 뷰컨트롤러의 View로 지정
        view = webView
        
        guard let urlLink = URL(string: "https://www.bignerdranch.com") else {
            print("Link 가 없다.")
            return
        }
        
        webView.load(URLRequest(url: urlLink))
    }
    
}
