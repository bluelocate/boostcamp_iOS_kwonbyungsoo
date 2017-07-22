//
//  ViewController.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button: YagomButton = YagomButton(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        
        button.setTitle("normal", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.backgroundColor = .black
        
        button.setTitle("highlighted1", for: [.normal, .highlighted])
        button.setTitleColor(.white, for: [.normal, .highlighted])
        
        button.setTitle("selected", for: .selected)
        button.setTitleColor(.green, for: .selected)
        
        button.setTitle("highlighted2", for: [.selected, .highlighted])
        button.setTitleColor(.red, for: [.selected, .highlighted])
        
        button.addAction(name: "first") { (sender: YagomButton) in
            print("touch up inside")
            sender.isSelected = !sender.isSelected
        }
        
        button.addTarget(self, action: #selector(self.touchUpButton(sender:)))
        
        self.view.addSubview(button)
        
        
        let disableButton: YagomButton = YagomButton(frame: CGRect(x: 50, y: 120, width: 200, height: 50))
        
        disableButton.setTitle("Disable the button", for: .normal)
        disableButton.setTitleColor(.black, for: .normal)
        disableButton.setTitle("Enable the button", for: .selected)
        
        disableButton.addAction(name: "en/disable") { (sender: YagomButton) in
            button.isEnabled = !button.isEnabled
            sender.isSelected = !sender.isSelected
        }
        self.view.addSubview(disableButton)
    }
    
    func touchUpButton(sender: MyButton) {
        print("button tapped")
    }
    
}

