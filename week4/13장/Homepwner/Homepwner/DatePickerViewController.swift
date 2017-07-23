//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 23..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(datePicker.date)
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else {
            return
        }
        detailViewController.date = datePicker.date
        
        print(detailViewController.date!)
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
    }
}
