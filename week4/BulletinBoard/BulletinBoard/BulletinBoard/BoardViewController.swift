//
//  ViewController.swift
//  BulletinBoard
//
//  Created by byung-soo kwon on 2017. 7. 21..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardList", for: indexPath) as! BoardListTableViewCell
        
        cell.threadTitle.text = "테스트 글"
        cell.commentCount.text = "39"
        cell.writeDate.text = "2017/03/04"
        return cell
    }

}

