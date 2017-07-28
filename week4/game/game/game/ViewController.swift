//
//  ViewController.swift
//  game
//
//  Created by byung-soo kwon on 2017. 7. 24..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    let itemArchiveURL: NSURL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive") as NSURL
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [ResultData] {
            manager.history += archivedItems
            print(archivedItems)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

