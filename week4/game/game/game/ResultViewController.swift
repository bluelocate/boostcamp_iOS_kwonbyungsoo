//
//  ResultViewController.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet weak var resultTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(manager.arrangedResult)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        manager.arrangedResult.removeAll()
        manager.history.removeAll()
        resultTableView.reloadData()
        manager.saveChanged()
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = manager.history[indexPath.row].name
        cell.detailTextLabel?.text = manager.history[indexPath.row].time
        return cell
    }
}
