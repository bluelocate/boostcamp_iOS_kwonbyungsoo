//
//  BoardListTableViewCell.swift
//  BulletinBoard
//
//  Created by byung-soo kwon on 2017. 7. 21..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class BoardListTableViewCell: UITableViewCell {

    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var writeDate: UILabel!
    @IBOutlet weak var threadTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
