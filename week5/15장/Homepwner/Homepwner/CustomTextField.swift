//
//  CustomTextField.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 23..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        if self.canBecomeFirstResponder {
            print("key")
            self.borderStyle = .line
            return true
        }
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.borderStyle = .roundedRect
        return true
    }
}
