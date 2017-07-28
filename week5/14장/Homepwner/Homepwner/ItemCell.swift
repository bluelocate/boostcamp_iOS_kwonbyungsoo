//
//  ItemCell.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 17..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        serialNumberLabel.font = caption1Font
    }
    
}
