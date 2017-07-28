//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 23..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func didSelectDate(date:Date)
}

class DatePickerViewController: UIViewController {
   
    @IBOutlet weak var datePicker: UIDatePicker!
    var datePickerDelegate: DatePickerDelegate!

    @IBAction func datePicker(_ sender: UIDatePicker) {

        print("데이트를 설정했다.")
        datePickerDelegate.didSelectDate(date: sender.date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
