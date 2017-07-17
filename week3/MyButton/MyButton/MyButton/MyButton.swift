//
//  MyButton.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class MyButton: UIView {
    
    let myLabel = UILabel()
    let myImage = UIImage()
    var controlState = UIControlState()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupButtons()
    }
    
    func setupButtons(){
        
        self.controlState = .normal
        self.backgroundColor = UIColor.blue
        self.isUserInteractionEnabled = true
        
        myLabel.text = "hello"
        myLabel.textColor = UIColor.black
        myLabel.isUserInteractionEnabled = true
        myLabel.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        self.addSubview(myLabel)
        
    }
    func hellos() {
        print("hello")
    }
    func hello(gestureRecognizer:UIGestureRecognizer) {
        
        self.controlState.update(with: .highlighted)
        
        print("hello")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.controlState == .normal {
            self.myLabel.text = "highlighted1"
            self.backgroundColor = UIColor.brown
            
        } else {
            self.myLabel.text = "highlighted2"
            self.backgroundColor = UIColor.red
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("터치 끝")
        if self.controlState == .normal {
            self.myLabel.text = "normal"
            self.backgroundColor = UIColor.green
            self.controlState = .selected
        } else {
            self.myLabel.text = "selected"
            self.backgroundColor = UIColor.blue
            self.controlState = .normal
        }
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents){
        print("hello")
        switch controlEvents {
        case UIControlEvents.touchUpInside:
            print("touch up")
        case UIControlEvents.touchDown:
            print("touch down")
        default:
            print("default")
        }
    }
    
    func setDisable() {
        self.backgroundColor = UIColor.gray
        self.isUserInteractionEnabled = false
    }
    
    func setEnable() {
        self.backgroundColor = UIColor.blue
        self.isUserInteractionEnabled = true
    }
    
}
