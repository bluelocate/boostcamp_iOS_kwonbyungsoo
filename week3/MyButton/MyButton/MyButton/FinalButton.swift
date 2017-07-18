//
//  MyButton.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class FinalButton: UIView {
    
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
        
        
    }
    
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        
    }
    
    func sendActions(for controlEvents: UIControlEvents) {
        
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
