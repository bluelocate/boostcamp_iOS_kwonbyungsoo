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

    @IBAction func datePicker(_ sender: UIDatePicker) {
        guard let viewController = navigationController?.viewControllers[1] as? DetailViewController else {
            return
        }
        viewController.item?.dateCreated = sender.date
    }
}
