//
//  MyButton.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class AnotherMyButton: UIView {
    
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
        self.backgroundColor = UIColor.gray
        self.isUserInteractionEnabled = true
        
        myLabel.text = "hello"
        myLabel.textColor = UIColor.black
        myLabel.isUserInteractionEnabled = true
        myLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.addSubview(myLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(control:)))
        self.addGestureRecognizer(gesture)
        
    }
    
    func tapGesture(control: UIControlState){
        
        switch self.controlState {
        case UIControlState.normal:
            setSelectedState()
        case UIControlState.selected:
            setNormalState()
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch self.controlState {
        case UIControlState.normal:
            setHighlightedState()
        case UIControlState.selected:
            setAnotherHighlightedState()
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        if self.bounds.contains(touchLocation) {
            return
        } else {
            switch self.controlState {
            case UIControlState.normal:
                setNormalState()
            case UIControlState.selected:
                setSelectedState()
            default:
                break
            }
            print("바운드 바깥쪽")
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
    
    func setSelectedState() {
        myLabel.text = "selected"
        self.backgroundColor = UIColor.blue
        controlState = .selected
    }
    
    func setNormalState() {
        myLabel.text = "normal"
        self.backgroundColor = UIColor.gray
        controlState = .normal
    }
    
    func setHighlightedState() {
        myLabel.text = "highlighted1"
        self.backgroundColor = UIColor.white
    }
    
    func setAnotherHighlightedState() {
        myLabel.text = "highlighted2"
        self.backgroundColor = UIColor.white
    }
}
