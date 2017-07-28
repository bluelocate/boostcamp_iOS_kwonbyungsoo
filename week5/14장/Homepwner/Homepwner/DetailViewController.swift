//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: CustomTextField!
    @IBOutlet var serialNumberField: CustomTextField!
    @IBOutlet var valueField: CustomTextField!
    @IBOutlet var dateLabel: UILabel!
    var date: Date? {
        didSet {
            print("changed \(date)")
        }
    }
    var item: Item?{
        didSet {
            navigationItem.title = item?.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let item = self.item else {
            return
        }
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: date ?? item.dateCreated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        guard let valueText = valueField.text else {
            return
        }
        guard let value = numberFormatter.number(from: valueText) else {
            return
        }
        item?.name = nameField.text ?? ""
        item?.serialNumber = serialNumberField.text
        item?.valueInDollars = value.intValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let segueway = segue.destination as? DatePickerViewController
        print("datepicker 의 delegate 는 나다.")
        segueway?.datePickerDelegate = self
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


extension DetailViewController: DatePickerDelegate {
    func didSelectDate(date: Date) {
        print("데이트가 바꼈다.")
        item?.dateCreated = date
    }
}
