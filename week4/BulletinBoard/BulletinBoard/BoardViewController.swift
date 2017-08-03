//
//  BoardViewController.swift
//  BulletinBoard
//
//  Created by byung-soo kwon on 2017. 7. 26..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import SnapKit
class BoardViewController: UIViewController {
    
    var boardList = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardList.delegate = self
        boardList.dataSource = self
        boardList.register(UITableViewCell.self, forCellReuseIdentifier: "boardListCell")
        self.view.addSubview(boardList)
        boardList.snp.makeConstraints { (item) in
            item.topMargin.equalTo(20)
            item.width.height.equalTo(self.view)
        }
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = boardList.dequeueReusableCell(withIdentifier: "boardListCell", for: indexPath)
        cell.textLabel?.text = "My First Programatical tableview!!"
        return cell
    }
}
