//
//  ViewController.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: AnotherMyButton!
    var isEnable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enableButton(_ sender: UIButton) {
        if isEnable{
            myButton.setDisable()
            isEnable = false
        } else {
            myButton.setEnable()
            isEnable = true
        }
    }

}
